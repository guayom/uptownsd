class AddQuotesToGameLines < ActiveRecord::Migration
  def change
    add_column :game_lines, :team1_odds, :integer
    add_column :game_lines, :team2_odds, :integer
  end
end
