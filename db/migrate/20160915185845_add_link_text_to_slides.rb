class AddLinkTextToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :slide_text, :string
  end
end
