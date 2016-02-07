class CreateGames < ActiveRecord::Migration
  def change
    create_table :game_lines do |t|

      t.timestamps null: false

      t.integer :sport_id
      t.integer :league_id
      t.integer :team1
      t.integer :team2
      t.date :date
      t.time :time
      t.integer :limit

    end
  end
end