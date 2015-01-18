json.array!(@advertisers) do |advertiser|
  json.extract! advertiser, :id, :name, :note, :level
  json.url advertiser_url(advertiser, format: :json)
end
