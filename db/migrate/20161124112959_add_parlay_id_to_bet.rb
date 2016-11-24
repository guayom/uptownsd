class AddParlayIdToBet < ActiveRecord::Migration
  def change
    add_reference :bets, :parlay
  end
end
