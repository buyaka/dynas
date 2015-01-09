json.array!(@entities) do |entity|
  json.extract! entity, :id, :name, :app_id, :note
  json.url entity_url(entity, format: :json)
end
