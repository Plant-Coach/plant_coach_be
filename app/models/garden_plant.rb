# GardenPlants are objects that the user has decided to plant.
class GardenPlant < ApplicationRecord
  validates_presence_of :plant_type,
                        :days_to_maturity,
                        :days_relative_to_frost_date,
                        :recommended_transplant_date,
                        :recommended_seed_sewing_date,
                        :seedling_days_to_transplant,
                        :planting_status,
                        :hybrid_status

  # Records must be unique according to name, but only unique for those that
  # belong to each user (aka "user_id").
  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :direct_seed_recommended, inclusion: [true, false]
  validates :start_from_seed, inclusion: [true, false]
  validates :direct_seeded, inclusion: [true, false]

  # GardenPlants belong to a user.
  belongs_to :user
  has_many :transplant_coachings
  has_many :transplant_guides, through: :transplant_coachings
  has_many :seed_coachings
  has_many :seed_guides, through: :seed_coachings
  has_many :harvest_coachings
  has_many :harvest_guides, through: :harvest_coachings

  # Hybrid Status can only be categorized as these three enumerables.
  enum hybrid_status: [:unknown, :open_pollinated, :f1]
  enum planting_status: ["not_started", "started_indoors",
    "direct_sewn_outside", "transplanted_outside"]

  before_save :update_planting_dates, if: :actual_seed_sewing_date_changed?
  before_save :new_transplant, if: :qualified_quick_plant
  # A GardenPlant requires fields that must be filled in and calculated by
  # SeedDefaultData.  This triggers the process after #create is called.
  after_initialize :generate_key_plant_dates, unless: :skip_callbacks
  after_initialize :add_seed_recommendation, unless: :skip_callbacks

  def update_planting_dates
    self.recommended_transplant_date = actual_seed_sewing_date + seedling_days_to_transplant
  end

  def generate_key_plant_dates
    user = User.find_by(id: self.user_id)
    default_seed_data = SeedDefaultData.find_by(plant_type: self.plant_type).seedling_days_to_transplant

    self.update(
      recommended_transplant_date: user.spring_frost_dates.to_date + self.days_relative_to_frost_date,
      recommended_seed_sewing_date: user.spring_frost_dates.to_date + self.days_relative_to_frost_date - default_seed_data,
      seedling_days_to_transplant: default_seed_data
    )
  end

  def add_seed_recommendation
    default_seed_data = SeedDefaultData.find_by(plant_type: self.plant_type)
    self.update(direct_seed_recommended: default_seed_data.direct_seed_recommended)
  end

  def new_transplant
    self.planting_status = "transplanted_outside"
  end

private
  def qualified_quick_plant
    !self.actual_transplant_date.nil? && self.start_from_seed == false
  end
end
