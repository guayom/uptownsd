class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :title
      t.text :excerpt
      t.text :description

      t.timestamps null: false
    end
  end
end
