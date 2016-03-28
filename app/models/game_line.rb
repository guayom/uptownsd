class GameLine < ActiveRecord::Base
  belongs_to :sport
  validates_presence_of :sport

  belongs_to :league

  belongs_to :team1, class_name: 'Team'
  validates_presence_of :team1

  belongs_to :team2, class_name: 'Team'
  validates_presence_of :team2

  has_attached_file :image,
                    styles: { medium: '700x450>', thumb: '272x174>' },
                    default_url: '/images/:style/missing.png',
                    url: '/system/:class/:style/:basename.:extension',
                    path: ':rails_root/public/system/:class/:style/:basename.:extension'
  validates_attachment_content_type :image, content_type: /\Aimage/

  scope :in_sport, -> (sport) { where(sport: sport) }
  scope :only_active, -> { where(active: true) }

  rails_admin do
    configure :game_info do
      visible false
    end

    list do
      field :active do
        column_width 60
      end
      field :game_info
      field :team1
      field :team1_odds
      field :team2_odds
      field :team2
      field :updated_at
    end

    edit do
      field :sport do
        inline_add false
        inline_edit false
      end
      field :league do
        inline_add false
        inline_edit false
      end
      field :team1
      field :team1_odds
      field :team2_odds
      field :team2
      field :date
      field :time
      field :limit
      field :image
      field :active
    end
  end

  def game_info
    "#{sport.title},<br> #{league.name}".html_safe
  end

  def title
    unless self.id.nil?
      "#{self.team1.name} vs. #{self.team2.name}"
    end
  end

  def formatted_date
    @date = self.date.strftime('%A, %b %d')
    @time = self.time.strftime('%H:%M%P')
    return "#{@date} - #{@time}"
  end
end
