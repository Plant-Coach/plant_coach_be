class StartedIndoorSeedSerializer
  include JSONAPI::Serializer
  attributes  :id,
              :recommended_transplant_date,
              :planting_status,
              :direct_seed_recommended,
              :plant_start_method,
              :recommended_seed_sewing_date,
              :actual_seed_sewing_date,
              :seedling_days_to_transplant,
              :actual_transplant_date
end
