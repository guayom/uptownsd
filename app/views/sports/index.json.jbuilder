json.array!(@sports) do |sport|
  json.extract! sport, :id, :title, :color
  json.url sport_url(sport, format: :json)
end
