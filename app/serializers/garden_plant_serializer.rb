class GardenPlantSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :plant_type,
              :recommended_transplant_date,
              :planting_status,
              :start_from_seed,
              :direct_seed_recommended,
              :seed_sew_type,
              :recommended_seed_sewing_date,
              :actual_seed_sewing_date,
              :seedling_days_to_transplant,
              :actual_transplant_date,
              :harvest_start,
              :harvest_finish,
              :harvest_period

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
