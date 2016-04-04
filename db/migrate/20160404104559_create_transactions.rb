class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.integer :kind, null: false
      t.references :bet, index: true, foreign_key: true
      t.decimal :amount, null: false

      t.timestamps null: false
    end
  end
end
