json.array!(@field_types) do |field_type|
  json.extract! field_type, :id, :name, :value, :note
  json.url field_type_url(field_type, format: :json)
end
