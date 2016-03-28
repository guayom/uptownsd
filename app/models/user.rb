class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bets
  has_many :draft_bets, -> { draft.order(created_at: :desc) }, class_name: 'Bet'

  def has_draft_bets?
    draft_bets.any?
  end
end
