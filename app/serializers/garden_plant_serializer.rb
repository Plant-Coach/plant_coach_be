class GardenPlantSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :recommended_transplant_date,
              :planting_status,
              :direct_seed_recommended,
              :plant_start_method,
              :recommended_seed_sewing_date,
              :actual_seed_sewing_date,
              :seedling_days_to_transplant,
              :actual_transplant_date,
              :harvest_start,
              :harvest_finish,
              :harvest_period,
              :plant_id

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
