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

  has_many :bets
  has_many :team1_bets, -> (l) { where(team_id: l.team1_id) }, class_name: 'Bet'
  has_many :team2_bets, -> (l) { where(team_id: l.team2_id) }, class_name: 'Bet'

  scope :in_sport, -> (sport) { where(sport: sport) }
  scope :only_active, -> { where(active: true) }

  rails_admin do
    configure :game_info do
      visible false
    end
    configure :teams_info do
      visible false
    end
    configure :odds_info do
      visible false
    end
    configure :bets_info do
      visible false
    end

    list do
      field :game_info
      field :teams_info
      field :odds_info
      field :bets_info
      field :active do
        column_width 60
      end
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

        # partial 'league'

        # associated_collection_cache_all false
        # associated_collection_scope do
        #   game_line = bindings[:object]
        #   Proc.new do |scope|
        #     scope = scope.where(sport_id: game_line.sport_id) if game_line.present?
        #     scope
        #   end
        # end
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

  def teams_info
    "#{team1.name}<hr>#{team2.name}".html_safe
  end

  def odds_info
    "#{team1_odds}<hr>#{team2_odds}".html_safe
  end

  def bets_info
    t1 = helpers.number_to_currency(team1_bets.map(&:risk).sum)
    t2 = helpers.number_to_currency(team2_bets.map(&:risk).sum)
    "#{t1}<hr>#{t2}".html_safe
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

  private

  def helpers
    ActionController::Base.helpers
  end
end
