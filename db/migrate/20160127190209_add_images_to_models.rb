class AddImagesToModels < ActiveRecord::Migration
  def self.up
    change_table :game_lines do |t|
      t.attachment :image
    end
    change_table :promotions do |t|
      t.attachment :image
    end
    change_table :slides do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :game_lines, :image
    remove_attachment :promotions, :image
    remove_attachment :slides, :image
  end
end
