class PlantSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :name,
              :plant_type,
              :days_relative_to_frost_date,
              :days_to_maturity,
              :hybrid_status,
              :organic,
              :harvest_period,
              :user_id

  def self.error(errors)
    {
    "error": errors.each do |error_message|
    end
    }
  end

  def self.delete_error(error_message)
    {
      "error": error_message
    }
  end
end
