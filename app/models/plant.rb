# Plants are considered records that each user wants to have in their personal
# database.
class Plant < ApplicationRecord
  validates_presence_of :name,
                        :plant_type,
                        :days_to_maturity,
                        :hybrid_status,
                        :days_relative_to_frost_date
  # "Inclusion" validates that the attribute belongs to an enumerable object.
  # validates_inclusion_of :organic, in: [true, false]
  # Plant records must be unique according to name, but only unique for those that
  # belong to each user, based on user_id.
  validates :name, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user

  enum hybrid_status: [:unknown, :open_pollinated, :f1]

  # unless: :skip_callbacks was introduced to help with erroneous validation test failures.
  after_initialize :set_defaults, unless: :skip_callbacks

  private
  
  # A user is not expected to know all of the details about a plant.  This fills
  # in some of the blanks with default data.
  def set_defaults
    plant_defaults = SeedDefaultData.find_by(plant_type: plant_type)
    self.update(days_to_maturity: plant_defaults.days_to_maturity) if days_to_maturity.nil?
    self.update(days_relative_to_frost_date: plant_defaults.days_relative_to_frost_date) if days_relative_to_frost_date.nil?
  end
end
