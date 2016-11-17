class AddKindToBet < ActiveRecord::Migration
  def change
    add_column :bets, :kind, :integer
  end
end
