class Bet < ActiveRecord::Base
  DEFAULT_RISK = 25.00

  enum status: { draft: 0, active: 1 }

  belongs_to :user
  belongs_to :game_line
  belongs_to :team

  validates_presence_of :user
  validates_presence_of :game_line
  validates_presence_of :team
  validates_presence_of :risk, unless: Proc.new { |bet| bet.draft? }
  validates_numericality_of :risk
end
