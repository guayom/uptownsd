class AddResultsToGameLines < ActiveRecord::Migration
  def change
    add_column :game_lines, :result_team_1, :integer
    add_column :game_lines, :result_team_2, :integer
  end
end
