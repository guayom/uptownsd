require 'rubygems'
require 'nokogiri'
require 'open-uri'
namespace :scrape_pinnacle do

  desc "Do some scrapping testing"
  task :football_nfl => :environment do
    sport_id = Sport.where(title: "Football").first.id
    games = Nokogiri::HTML(open("http://www.foxsports.com/nfl/odds?season=2016&seasonType=1&week=1&type=0"))
    games.css(".wisbb_gameWrapper").each do |game_table|
      game = GameLine.new(:sport_id => Sport.where(title: 'Football').first.id, :league_id => League.where(name: "NFL").first.id)
    	#Get datetime
      date_string = game_table.css('.wisbb_oddsGameDate').text.strip!
    	date = DateTime.parse(date_string)
      if date_string[-4, 4] == "p ET"
        date = date + 12.hours
      end
      game.attributes = {:time => date}

    	#get team names
    	@teams = []
    	game_table.css('.wisbb_teamCity').each_with_index do |city, index|
    		@teams << city.text
    	end
    	game_table.css('.wisbb_teamName').each_with_index do |team, index|
    		@teams[index] = "#{@teams[index]} #{team.text}"
    	end
      #Check if the teams exist, if not, create it, and collect their id's
      @team_ids = []
      @teams.each_with_index do |team, index|
        if Team.where(name: team, sport_id: sport_id).any?
          @team_ids << Team.where(name: team, sport_id: sport_id).first.id
        else
          puts "#{team} - Doesn't exist"
          Team.create(name: team, sport_id: sport_id)
        end
      end
      #Once teams exist and we have their id's, assign team attributes to the game
      game.attributes = {team1_id: @team_ids[0], team2_id: @team_ids[1]}

      #Odds sources
      @selected_source = "BOVADA.lv"
      @odds_sources = []
      game_table.css('.wisbb_oddsTable tbody tr').each_with_index do |source, index|
        source_title = source.css('.wisbb_bookCol').text
        @odds_sources << source_title
        if source_title == @selected_source
          runLinePts = source.css('.wisbb_runLinePtsCol').inner_html.split('<br>')
          spread_vals = source.css('.wisbb_runLineValsCol').inner_html.split('<br>')
          over_under_vals = source.css('.wisbb_overUnderValsCol').inner_html.split('<br>')
          moneyline_vals = source.css('.wisbb_moneyLineCol').inner_html.split('<br>')
          game.attributes = {
            spread_pts_team_1: runLinePts[0].to_i,
            spread_pts_team_2: runLinePts[1].to_i,
            spread_val_team_1: spread_vals[0].to_i,
            spread_val_team_2: spread_vals[1].to_i,
            over_under_total: source.css('.wisbb_overUnderCol').text,
            over_under_val_team_1: over_under_vals[0].tr("o:", "").to_i,
            over_under_val_team_2: over_under_vals[1].tr("u:", "").to_i,
            money_line_team_1: moneyline_vals[0].to_i,
            money_line_team_2: moneyline_vals[1].to_i
          }
        end
      end

      #Check if game is active
      if date.to_date.future?
        puts "Game is in the future"
        game.attributes = {active: true}
      end

      if GameLine.where(time: date, team1_id: @team_ids[0], team2_id: @team_ids[1]).empty?
        game.save
        puts "Game Saved"
        puts game.inspect
        puts '---'
      else
        puts "Game already exists"
        puts game.inspect
        puts '---'
      end
    end
  end
end
