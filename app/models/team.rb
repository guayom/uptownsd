class Team < ActiveRecord::Base
	#has_many :primary_team, :class_name => "Team", :foreign_key => "team_1_id"
  	#has_many :secondary_team, :class_name => "Team", :foreign_key => "team_2_id"
  	has_many :game_lines_as_primary, :class_name => 'GameLine', :foreign_key => 'team_1_id'
  	has_many :game_lines_as_secondary, :class_name => 'GameLine', :foreign_key => 'team_2_id'
	belongs_to :sport

	def game_lines
     game_lines_as_primary + game_lines_as_secondary
  end
end
