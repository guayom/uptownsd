class Bet < ActiveRecord::Base
  DEFAULT_RISK = 10.00

  enum status: { draft: 0, active: 1, lost: 2, won: 3 }
  enum kind: { moneyline: 1, spread: 2, total: 3, straight: 4, parlay: 5 }

  belongs_to :user
  belongs_to :game_line
  belongs_to :team

  has_many :transactions, dependent: :destroy

  validates_presence_of :user
  validates_presence_of :kind
  validates_presence_of :game_line
  validates_presence_of :team
  validates_presence_of :risk, unless: :straight?
  validates_numericality_of :risk, greater_than_or_equal_to: 5, less_than_or_equal_to: 200, unless: :straight?

  validate on: :create do |bet|
    unless bet.straight?
      if bet.risk > user.balance
        errors.add(:risk, 'cannot be bigger than current balance.')
      end
    end
  end

  scope :archived, -> { where(status: [:lost, :won]) }

  after_create do
    unless self.straight?
      t = self.user.transactions.build
      t.kind = :make_bet
      t.amount = -self.risk
      t.bet = self
      t.save!
    end
  end

  def odds
    game_line.team1 == team ? game_line.team1_odds : game_line.team2_odds
  end

  def moneyline
    game_line.team1 == team ? game_line.money_line_team_1 : game_line.money_line_team_2
  end

  def spread_points
    game_line.team1 == team ? game_line.spread_pts_team_1 : game_line.spread_pts_team_2
  end

  def spread_value
    game_line.team1 == team ? game_line.spread_val_team_1 : game_line.spread_val_team_2
  end

  def total_value
    game_line.team1 == team ? game_line.over_under_val_team_1 : game_line.over_under_val_team_2
  end

  def win
    return 0 unless odds.present?

    win = if odds > 0
            risk * (odds / 100.0)
          else
            risk / (-1.0 * odds / 100.0)
          end

    win.round(2)
  end

  def payout
    (win + risk).round(2)
  end

  def to_s
    "#{team.name} (#{odds >= 0 ? '+' + odds.to_s : odds})"
  end

  def kind_description
    case kind.to_sym
    when :moneyline then
      "moneyline #{moneyline}"
    when :spread then
      "spread #{spread_points} / #{spread_value}"
    when :total then
      "total #{game_line.over_under_total} O/U / #{total_value}"
    when :straight then
      'parlay'
    end
  end
end
