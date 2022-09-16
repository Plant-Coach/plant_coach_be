class GardenPlantSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :name,
              :plant_type,
              :days_relative_to_frost_date,
              :recommended_transplant_date,
              :days_to_maturity,
              :hybrid_status,
              :organic


  def self.error(message)
    {
      "error": message
    }
  end

  def self.confirm
    {
      "status": "success"
    }
  end
end
