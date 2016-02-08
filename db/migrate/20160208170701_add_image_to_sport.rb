class AddImageToSport < ActiveRecord::Migration
  def change
  	add_attachment :sports, :image
  end
end
