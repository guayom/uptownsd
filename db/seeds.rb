#Admin
Admin.create(email: "guayo.mena@gmail.com", password: ENV["admin_password"], password_confirmation: ENV["admin_password"] ) if Rails.env.development?

@sports = ["Football", "Baseball", "Basketball"]
@sports.each do |sport|
	Sport.create(title: sport)
end

@leagues = [
	{:sport => "Football", :name => "NFL", :abbreviation => "NFL"},
	{:sport => "Baseball", :name => "MLB", :abbreviation => "MLB"},
	{:sport => "Basketball", :name => "NBA", :abbreviation => "NBA"}
]
@leagues.each do |league|
	League.create(sport_id: Sport.where(title: league[:sport]).first.id, name: league[:name], abbreviation: league[:abbreviation])
end

require 'rubygems'
require 'nokogiri'
require 'open-uri'

football_teams = Nokogiri::HTML(open("https://en.wikipedia.org/wiki/Lists_of_National_Football_League_team_seasons"))
football_teams.css(".wikitable .sortbottom .mw-redirect").each do |row|
	Team.create(name: row.text, sport_id: Sport.where(title: "Football").first.id)
end

baseball_teams = Nokogiri::HTML(open("http://mlb.mlb.com/team/index.jsp"))
baseball_teams.css(".team h5 a").each do |row|
	Team.create(name: row.text, sport_id: Sport.where(title: "Baseball").first.id)
end

baseball_teams = Nokogiri::HTML(open("http://www.nba.com/teams/"))
baseball_teams.css(".nbateamname a").each do |row|
	Team.create(name: row.text, sport_id: Sport.where(title: "Basketball").first.id)
end
