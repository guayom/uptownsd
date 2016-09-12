class AddSpreadToGameLines < ActiveRecord::Migration
  def change
    add_column :game_lines, :spread_pts_team_1, :integer
    add_column :game_lines, :spread_pts_team_2, :integer
    add_column :game_lines, :spread_val_team_1, :integer
    add_column :game_lines, :spread_val_team_2, :integer
    add_column :game_lines, :over_under_total, :integer
    add_column :game_lines, :over_under_val_team_1, :integer
    add_column :game_lines, :over_under_val_team_2, :integer
    add_column :game_lines, :money_line_team_1, :integer
    add_column :game_lines, :money_line_team_2, :integer
  end
end
