#Admin
Admin.create(email: "guayo.mena@gmail.com", password: ENV["admin_password"], password_confirmation: ENV["admin_password"] )
#Baseball teams
@football = Sport.new(title: 'Football')
@nfl = League.new(sport: @football, name: "NFL", abbreviation: "NFL" )
