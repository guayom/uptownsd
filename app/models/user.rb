class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bets
  has_many :draft_bets, -> { draft.order(created_at: :desc) }, class_name: 'Bet'
  has_many :transactions

  rails_admin do
    configure :balance_info do
      visible false
    end

    list do
      field :email
      field :balance_info
    end
  end

  def has_draft_bets?
    draft_bets.any?
  end

  def balance
    transactions.sum(:amount)
  end

  def balance_info
    helpers.number_to_currency(balance)
  end

  private

  def helpers
    ActionController::Base.helpers
  end
end
