class Bet < ActiveRecord::Base
  DEFAULT_RISK = 10.00

  enum status: { draft: 0, active: 1 }

  belongs_to :user
  belongs_to :game_line
  belongs_to :team

  validates_presence_of :user
  validates_presence_of :game_line
  validates_presence_of :team
  validates_presence_of :risk, unless: Proc.new { |bet| bet.draft? }
  validates_numericality_of :risk

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
end
