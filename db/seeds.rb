sports = %w(Basketball Soccer Football Tennis)
sports.each_with_index do |title, i|
	puts "Creating #{i+1}/#{sports.count} sport"
	sport = Sport.new(title: title)
	sport.image = File.open(Rails.root.join("test/fixtures/images/#{title}.jpg"))
	sport.color = Faker::Color.color_name
	sport.save!
	8.times do
		team = sport.teams.new(name: Faker::Team.name)
		team.logo = File.open(Dir[Rails.root.join('test/fixtures/logos/*')].sample)
		team.save!
	end	
end