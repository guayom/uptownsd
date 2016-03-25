class RenameFieldsInGameLine < ActiveRecord::Migration
  def change
    rename_column :game_lines, :team_1_id, :team1_id
    rename_column :game_lines, :team_2_id, :team2_id
  end
end
