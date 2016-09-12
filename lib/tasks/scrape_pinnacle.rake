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

      #check if the game line exists
      #check Gamelines or a game that has the same datetime, team 1 and team 2

      @teams.each_with_index do |team, index|
        if Team.where(name: team, sport_id: sport_id).any?
          if index == 0
            game.attributes = {team1_id: Team.where(name: team, sport_id: sport_id).first.id}
          else
            game.attributes = {team2_id: Team.where(name: team, sport_id: sport_id).first.id}
          end
        else
          puts "#{team} - Doesn't exist"
          Team.create(name: team, sport_id: sport_id)
          if index == 0
            game.attributes = {team1_id: Team.where(name: team, sport_id: sport_id).first.id}
          else
            game.attributes = {team2_id: Team.where(name: team, sport_id: sport_id).first.id}
          end
        end
      end

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
      GameLine.save if GameLine.where(time: date, team1_id: @teams[0], team2_id: @teams[1]).nil?
    end
  end
end
