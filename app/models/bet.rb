class Bet < ActiveRecord::Base
  DEFAULT_RISK = 10.00

  enum status: { draft: 0, active: 1, lost: 2 }

  belongs_to :user
  belongs_to :game_line
  belongs_to :team

  has_many :transactions

  validates_presence_of :user
  validates_presence_of :game_line
  validates_presence_of :team
  validates_presence_of :risk
  validates_numericality_of :risk

  validate on: :create do |bet|
    if bet.risk > user.balance
      errors.add(:risk, 'cannot be bigger than current balance.')
    end
  end

  def odds
    game_line.team1 == team ? game_line.team1_odds : game_line.team2_odds
  end

  def win
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
    "#{team.name} (#{odds >= 0 ? '+' + odds : odds})"
  end
end
