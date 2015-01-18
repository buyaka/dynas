json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :name, :note, :start_date, :end_date, :advertiser_id
  json.url campaign_url(campaign, format: :json)
end
