class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :title
      t.string :color

      t.timestamps null: false
    end
  end
end
