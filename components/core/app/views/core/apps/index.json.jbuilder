json.array!(@apps) do |app|
  json.extract! app, :id, :name, :member_id, :note, :api_key
  json.url app_url(app, format: :json)
end
