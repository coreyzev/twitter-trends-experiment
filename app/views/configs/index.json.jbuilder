json.array!(@configs) do |config|
  json.extract! config, :id, :address, :location_id, :limit
  json.url config_url(config, format: :json)
end
