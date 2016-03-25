class League < ActiveRecord::Base
	belongs_to :sport

  validates_presence_of :sport
  validates_presence_of :name

  has_many :game_lines

	rails_admin do
		list do
			field :sport
			field :name
			field :abbreviation
			field :updated_at
		end

		edit do
			field :sport do
				inline_add false
				inline_edit false
			end
			field :name do
			end
			field :abbreviation do
			end
		end
	end
end
