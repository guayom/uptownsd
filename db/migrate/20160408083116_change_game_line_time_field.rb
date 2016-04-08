class ChangeGameLineTimeField < ActiveRecord::Migration
  def change
    remove_column :game_lines, :date
    remove_column :game_lines, :time
    add_column :game_lines, :time, :datetime
  end
end
