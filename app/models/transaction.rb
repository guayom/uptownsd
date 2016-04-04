class Transaction < ActiveRecord::Base
  enum kind: { deposit: 0, make_bet: 1, get_the_win: 2 }

  belongs_to :user
  belongs_to :bet

  validates_presence_of :user
  validates_presence_of :kind
  validates_presence_of :amount
  validates_numericality_of :amount
end
