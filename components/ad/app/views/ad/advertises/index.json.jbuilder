json.array!(@ads) do |ad|
  json.extract! ad, :id, :name, :note, :ad_type_id, :advertiser_id
  json.url ad_url(ad, format: :json)
end
