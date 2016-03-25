class AddAbbreviationToLeague < ActiveRecord::Migration
  def change
    add_column :leagues, :abbreviation, :string
  end
end
