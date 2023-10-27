class PlantGuideSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :plant_type,
              :direct_seed_recommended,
              :seedling_days_to_transplant,
              :days_to_maturity,
              :days_relative_to_frost_date,
              :harvest_period,
              :user_id

  def self.all_guides(plant_guides)
    {
      "plant_guides": plant_guides.each do |guide|
      end
    }
  end

  def self.message(message)
    {
      "status": message
    }
  end

  def self.errors(error_messages)
    {
      "errors": error_messages.each do |message|
      end
    }
  end 

  def self.error(message)
    {
      "error": message
    }
  end
end
