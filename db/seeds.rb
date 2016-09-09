#Admin

Admin.create(email: "guayo.mena@gmail.com", password: ENV["admin_password"], password_confirmation: ENV["admin_password"] ) if Rails.env.development?

#Baseball teams
@football = Sport.new(title: 'Football')
@nfl = League.new(sport: @football, name: "NFL", abbreviation: "NFL" )
