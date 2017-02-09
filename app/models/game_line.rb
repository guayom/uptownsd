class GameLine < ActiveRecord::Base
  belongs_to :sport
  validates_presence_of :sport

  belongs_to :league

  belongs_to :team1, class_name: 'Team', inverse_of: :game_lines_as_team1
  validates_presence_of :team1

  belongs_to :team2, class_name: 'Team', inverse_of: :game_lines_as_team2
  validates_presence_of :team2

  has_attached_file :image,
                    styles: { medium: '700x450>', thumb: '272x174>' },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: /\Aimage/

  has_many :bets, dependent: :destroy
  has_many :team1_bets, -> (l) { where(team_id: l.team1_id) }, class_name: 'Bet'
  has_many :team2_bets, -> (l) { where(team_id: l.team2_id) }, class_name: 'Bet'

  scope :in_sport, -> (sport) { where(sport: sport) }
  scope :only_active, -> { where(active: true) }

  scope :upcoming, -> (count = 6) {
    includes(:team1, :team2).
      where('time >= ?', Time.zone.now).limit(count).order(time: :desc)
  }

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
      filters [:time, :game_info]

      field :time
      field :game_info do
        searchable [{sport: :title}]
      end
      field :teams_info
      field :odds_info
      field :bets_info
      field :active do
        column_width 60
      end
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

      field :time

      field :team1
      field :spread_pts_team_1
      field :spread_val_team_1
      field :over_under_val_team_1
      field :money_line_team_1

      field :team2
      field :spread_pts_team_2
      field :spread_val_team_2
      field :over_under_total
      field :over_under_val_team_2
      field :money_line_team_2

      field :place
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
      "#{self.team1.name} vs. #{self.team2.name} (#{formatted_time})"
    end
  end

  def formatted_time
    time.strftime('%A, %b %d - %H:%M%P')
  end

  def process_results!(winner_team)
    if team1 != winner_team && team2 != winner_team
      fail "That team doesn't take part in this game."
    end
  end

  private

  def helpers
    ActionController::Base.helpers
  end
end
