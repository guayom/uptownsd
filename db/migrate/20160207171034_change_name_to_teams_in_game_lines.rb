class ChangeNameToTeamsInGameLines < ActiveRecord::Migration
  def change
  	rename_column :game_lines, :team1, :team_1_id
  	rename_column :game_lines, :team2, :team_2_id
  end
end
