class AddStatusToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :confirmed, :boolean
  end
end
