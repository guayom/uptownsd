class Team < ActiveRecord::Base
	has_attached_file :logo,
										styles: { large: '900x900>', thumb: '250x250>' },
										default_url: '/images/:style/missing.png'
  validates_attachment_content_type :logo, content_type: /\Aimage/

	belongs_to :sport

  validates_presence_of :sport
  validates_presence_of :name

	has_many :game_lines_as_team1, class_name: 'GameLine', foreign_key: :team1_id, dependent: :destroy
	has_many :game_lines_as_team2, class_name: 'GameLine', foreign_key: :team2_id, dependent: :destroy
	has_many :game_results
end
