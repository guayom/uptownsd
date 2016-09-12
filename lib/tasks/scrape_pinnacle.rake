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
          runLinePts = source.css('.wisbb_runLinePtsCol').html
          puts runLinePts.inspect

          game.attributes = {
            spread_pts_team_1: runLinePts[0],
            spread_pts_team_2: runLinePts[1]
            # spread_val_team_1: ,
            # spread_val_team_2: ,
            # over_under_total: ,
            # over_under_val_team_1: ,
            # over_under_val_team_2: ,
            # money_line_team_1: ,
            # money_line_team_2:
          }
        end
      end

      #puts game.inspect
    end
  end
end
