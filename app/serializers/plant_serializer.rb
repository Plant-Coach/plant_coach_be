class PlantSerializer
  include JSONAPI::Serializer
  attributes :plant_type, :name, :days_relative_to_frost_date, :days_to_maturity, :hybrid_status
end
