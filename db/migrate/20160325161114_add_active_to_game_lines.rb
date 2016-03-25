class AddActiveToGameLines < ActiveRecord::Migration
  def change
    add_column :game_lines, :active, :boolean, default: false
  end
end
