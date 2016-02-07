json.array!(@slides) do |slide|
  json.extract! slide, :id, :title, :description, :link
  json.url slide_url(slide, format: :json)
end
