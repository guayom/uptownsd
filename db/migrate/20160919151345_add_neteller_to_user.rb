class AddNetellerToUser < ActiveRecord::Migration
  def change
    add_column :users, :neteller, :string
  end
end
