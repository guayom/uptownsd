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
