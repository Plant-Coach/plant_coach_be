class PlantSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :name,
              :plant_type,
              :days_relative_to_frost_date,
              :days_to_maturity,
              :hybrid_status,
              :organic


  def self.error(message)
    {
      "error": message
    }
  end
end
