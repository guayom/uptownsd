class GameLine < ActiveRecord::Base
	belongs_to :sport, inverse_of: :game_lines

	belongs_to :league

	belongs_to :team_1, :class_name => "Team"
	belongs_to :team_2, :class_name => "Team"

	has_attached_file :image, 
	styles: { medium: "700x450>", thumb: "272x174>" }, 
	default_url: "/images/:style/missing.png",
	:url => "/system/:class/:style/:basename.:extension",
  	:path => ":rails_root/public/system/:class/:style/:basename.:extension"
	validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  scope :only_active, -> { where(active: true) }

  rails_admin do
    list do
      field :active
      field :sport
      field :league
      field :team1
      field :team2
      field :updated_at
    end
  end

	def title
		unless self.id.nil?
			"#{self.team_1.name} vs. #{self.team_2.name}"
		end
	end

	def formatted_date
		@date = self.date.strftime("%A, %b %d")
		@time = self.time.strftime("%H:%M%P")
		return "#{@date} - #{@time}"
	end

	scope :sport, lambda { |sport| where(:sport_id => sport) }

end
