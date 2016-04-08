class GameResult < ActiveRecord::Base
  belongs_to :game_line
  belongs_to :team

  after_create do |game_result|
    game_result.transaction do
      # We should process all bets and add win transactions.
      game_result.game_line.bets.each do |bet|
        if game_result.team == bet.team
          # Win!
          bet.user.transactions.create!(kind: :win, amount: bet.payout)
        end
      end
    end
  end

  rails_admin do
    edit do
      field :game_line do
        inline_add false
        inline_edit false
      end

      field :team do
        inline_add false
        inline_edit false
      end
    end
  end
end
