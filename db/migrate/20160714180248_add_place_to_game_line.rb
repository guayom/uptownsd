class AddPlaceToGameLine < ActiveRecord::Migration
  def change
    add_column :game_lines, :place, :text
  end
end
