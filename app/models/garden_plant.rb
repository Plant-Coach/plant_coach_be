# GardenPlants are objects that the user has decided to plant.
class GardenPlant < ApplicationRecord
  # include ActiveModel::Dirty

  validates_presence_of :seedling_days_to_transplant,
                        :planting_status,
                        :plant_start_method

  validates :direct_seed_recommended, inclusion: [true, false]
  validates :actual_transplant_date, presence: {
    message: 'You must specify a transplant date!'
  }, unless: lambda {
       ['transplanted_outside'].exclude?(planting_status)
     }
  validates :actual_seed_sewing_date, presence: {
    message: 'You must specify a seed-sewing date!'
  }, unless: lambda {
       %w[started_indoors direct_sewn_outside].exclude?(planting_status)
     }
  validates :recommended_transplant_date, presence: {
    message: 'A recommended transplant date is not being generated but should be since plant_start_method is not direct_sew!'
  }, unless: lambda {
       %w[indirect_sew direct_transplant].exclude?(plant_start_method)
     }
  validates :recommended_seed_sewing_date, presence: {
    message: 'A recommended seed-sewing date is required for indirect and direct sewing!'
  }, unless: lambda {
       ['indirect_sew, direct_sew'].exclude?(plant_start_method)
     }

  belongs_to :plant

  enum :hybrid_status, { unknown: 0, open_pollinated: 1, f1: 2 }
  enum :planting_status, { not_started: 0, started_indoors: 1,
                           direct_sewn_outside: 2, transplanted_outside: 3 }
  enum :plant_start_method, { indirect_sew: 0, direct_sew: 1, direct_transplant: 2 }
  enum :harvest_period, { season_long: 0, four_week: 1, three_week: 2, two_week: 3, one_week: 4, one_time: 5 }

  before_save :update_planting_dates, if: :actual_seed_sewing_date_changed?

  # A GardenPlant requires fields that must be filled in and calculated by
  # the data in the guides.  This triggers the process after #create is called.
  after_initialize :generate_key_plant_dates, unless: :skip_callbacks
  after_initialize :add_seed_recommendation, unless: :skip_callbacks
  after_initialize :set_started_indoors, if: :started_indoors
  after_initialize :set_direct_future_sew_seed, if: :direct_future_sew

  def update_planting_dates
    return unless plant_start_method != 'direct_sew'

    self.recommended_transplant_date = actual_seed_sewing_date + seedling_days_to_transplant
  end

  def generate_key_plant_dates
    user = plant.user

    default_seed_data = user.plant_guides.find_by(plant_type: plant.plant_type).seedling_days_to_transplant
    if %w[indirect_sew direct_transplant].include?(plant_start_method)
      self.recommended_transplant_date = user.spring_frost_date.to_date + plant.days_relative_to_frost_date
    end
    self.recommended_seed_sewing_date = user.spring_frost_date.to_date + plant.days_relative_to_frost_date - default_seed_data

    self.seedling_days_to_transplant = default_seed_data
    self.harvest_start = user.spring_frost_date.to_date + plant.days_relative_to_frost_date + plant.days_to_maturity

    harvest_period = user.plant_guides.find_by(plant_type: plant.plant_type).harvest_period
    self.harvest_period = harvest_period

    case harvest_period
    when 'season_long'
      self.harvest_finish = user.fall_frost_date.to_date
    when 'four_week'
      self.harvest_finish = harvest_start + 28
    when 'three_week'
      self.harvest_finish = harvest_start + 21
    when 'two_week'
      self.harvest_finish = harvest_start + 14
    when 'one_week'
      self.harvest_finish = harvest_start + 7
    when 'one_time'
      self.harvest_finish = harvest_start
    end
  end

  def add_seed_recommendation
    default_seed_data = plant.user.plant_guides.find_by(plant_type: plant.plant_type)
    self.direct_seed_recommended = default_seed_data.direct_seed_recommended
  end

  def set_started_indoors
    self.planting_status = 'started_indoors'
  end

  def set_direct_future_sew_seed
    self.recommended_seed_sewing_date = plant.user.spring_frost_date.to_date + plant.days_relative_to_frost_date
  end

  private

  def started_indoors
    plant_start_method == 'indirect_sew' && !actual_seed_sewing_date.nil? && actual_transplant_date.nil?
  end

  def direct_future_sew
    plant_start_method == 'direct_sew' && actual_seed_sewing_date.nil?
  end
end
