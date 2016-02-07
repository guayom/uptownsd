json.array!(@game_lines) do |game|
  json.extract! game, :id, :sport_id, :date
  json.url game_url(game, format: :json)
end
