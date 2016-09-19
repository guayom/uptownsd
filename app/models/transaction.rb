class Transaction < ActiveRecord::Base
  enum kind: { deposit: 0, make_bet: 1, get_the_win: 2, lose_bet: 3, win: 4 }

  belongs_to :user
  belongs_to :bet

  scope :lost, -> { make_bet.joins(:bet).where(bets: { status: 2 }) }
  scope :deposits_to_confirm, -> { deposit.where('confirmed IS NULL OR confirmed IS FALSE') }

  validates_presence_of :user
  validates_presence_of :kind
  validates_presence_of :amount
  validates_numericality_of :amount

  def neteller
    user.neteller
  end
end
