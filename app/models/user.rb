class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bets, -> { order(created_at: :desc) }
  has_many :transactions

  rails_admin do
    configure :balance_info do
      visible false
    end
    configure :total_won_info do
      visible false
    end
    configure :total_lost_info do
      visible false
    end

    list do
      field :email
      field :balance_info
      field :total_won_info
      field :total_lost_info
      field :created_at
    end
  end

  def has_active_bets?
    bets.active.any?
  end

  def balance
    transactions.sum(:amount)
  end

  def balance_info
    helpers.number_to_currency(balance)
  end

  def total_won
    transactions.get_the_win.sum(:amount).abs
  end

  def total_won_info
    helpers.number_to_currency(total_won)
  end

  def total_lost
    transactions.lost.sum(:amount)
  end

  def total_lost_info
    helpers.number_to_currency(total_lost)
  end

  def empty_balance?
    balance <= 0
  end

  private

  def helpers
    ActionController::Base.helpers
  end
end
