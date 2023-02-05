# GardenPlants are objects that the user has decided to plant.
class GardenPlant < ApplicationRecord
  validates_presence_of :name,
                        :plant_type,
                        :days_to_maturity,
                        :hybrid_status,
                        :days_relative_to_frost_date,
                        :recommended_transplant_date,
                        :direct_seed_recommendation,
                        # :direct_seed_user_decision,
                        :recommended_seed_sewing_date,
                        :seedling_days_to_transplant,
                        :start_from_seed,
                        :planting_status
  # Records must be unique according to name, but only unique for those that
  # belong to each user (aka "user_id").
  validates :name, presence: true, uniqueness: { scope: :user_id }

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
  enum direct_seed_recommendation: [:no, :yes]
  enum direct_seed_user_decision: [:direct, :indirect]

  # _changed? is built-in ActiveRecord Rails magic that knows if an attribute was changed.
  before_save :update_planting_dates, if: :actual_seed_sewing_date_changed?

  # A GardenPlant requires fields that must be filled in and calculated by
  # SeedDefaultData.  This triggers the process after #create is called.
  after_initialize :generate_key_plant_dates, unless: :skip_callbacks

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
    # binding.pry
  end


end
