class FrostDateSerializer
  include JSONAPI::Serializer
  attributes :id, :zip_code, :location_name, :lat, :lon, :spring_frost, :fall_frost
end
