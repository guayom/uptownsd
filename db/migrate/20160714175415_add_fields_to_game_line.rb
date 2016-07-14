class AddFieldsToGameLine < ActiveRecord::Migration
  def change
    add_column :game_lines, :team1_line, :string
    add_column :game_lines, :team1_total, :string
    add_column :game_lines, :team2_line, :string
    add_column :game_lines, :team2_total, :string
  end
end
