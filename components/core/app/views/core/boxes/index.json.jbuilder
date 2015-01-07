json.array!(@boxes) do |box|
  json.extract! box, :id, :name, :app_id, :note
  json.url box_url(box, format: :json)
end
