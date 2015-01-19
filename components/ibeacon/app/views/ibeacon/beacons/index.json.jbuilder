json.array!(@beacons) do |beacon|
  json.extract! beacon, :id, :uuid, :major, :minor
  json.url beacon_url(beacon, format: :json)
end
