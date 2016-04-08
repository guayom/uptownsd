class CreateGameResults < ActiveRecord::Migration
  def change
    create_table :game_results do |t|
      t.references :game_line, index: true, foreign_key: true, null: false
      t.references :team, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
