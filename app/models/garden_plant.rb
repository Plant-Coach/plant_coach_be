# GardenPlants are objects that the user has decided to plant.
class GardenPlant < ApplicationRecord
  validates_presence_of :name,
                        :plant_type,
                        :days_to_maturity,
                        :hybrid_status,
                        :days_relative_to_frost_date,
                        :recommended_transplant_date,
                        # :direct_seed,
                        :recommended_seed_sewing_date,
                        :seedling_days_to_transplant,
                        :start_from_seed,
                        :planting_status

  # Records must be unique according to name, but only unique for those that
  # belong to each user (aka "user_id").
  validates :name, presence: true, uniqueness: { scope: :user_id }

  # GardenPlants belong to a user.
  belongs_to :user

  # Hybrid Status can only be categorized as these two enumerables.
  enum hybrid_status: [:unknown, :open_pollinated, :f1]

  enum planting_status: ["not_started", "started_indoors", "direct_sewn_outside", "transplanted_outside"]

  # _changed? is built-in ActiveRecord Rails magic that knows if an attribute was changed.
  before_save :update_planting_dates, if: :actual_seed_sewing_date_changed?

  def update_planting_dates
    self.projected_seedling_transplant_date = actual_seed_sewing_date + seedling_days_to_transplant
  end
end
