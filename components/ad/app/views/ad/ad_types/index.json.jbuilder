json.array!(@ad_types) do |ad_type|
  json.extract! ad_type, :id, :name, :height, :width, :note
  json.url ad_type_url(ad_type, format: :json)
end
