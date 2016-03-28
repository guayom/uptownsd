class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.references :user, index: true, foreign_key: true
      t.references :game_line, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true
      t.decimal :risk
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
