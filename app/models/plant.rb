# Plants are considered records that each user wants to have in their personal
# database.
class Plant < ApplicationRecord
  # Plant records must be unique according to name, but only unique for those that
  # belong to each user, based on user_id.

  # Plant names should be unique, per plant type, per user.
  # ex... A user can have two plants with the same name, only as long as the plant types are different.
  # ie... A user can not have two plants with the same name and the same plant_type.
  validates :name, presence: true, uniqueness: { 
    scope: [:plant_type, :user_id],
    message: ->(object, data) do
      "A #{object.plant_type} plant named #{object.name} already exists for #{object.user.name}!"
    end
  }
  validates :plant_type, presence: { message: "'Plant Type' can not be blank!" }
  validates :days_to_maturity, 
    presence: {
      message: "'Days to Maturity' can not be blank!"
      },
      numericality: {
        only_integer: true,
        greater_than: 0,
        message: "Days to Maturity must be an integer, greater than 0!"
      }
  validates :hybrid_status, presence: true
  validates :days_relative_to_frost_date, 
    presence: {
      message: "'Days Relative to Frost Date' can not be blank!" 
    },
    numericality: {
      only_integer: true,
      message: "Days Relative to Frost Date must be a whole number, and can be postive or negative!" 
    }
  validates :organic, inclusion: { in: [true, false] }

  belongs_to :user
  has_many :garden_plants

  enum hybrid_status: [:unknown, :open_pollinated, :f1]
  enum harvest_period: [:season_long, :four_week, :three_week, :two_week, :one_week, :one_time]

  after_initialize :set_defaults, unless: :skip_callbacks

  private

  # A user is not expected to know all of the details about a plant.  This fills
  # in some of the blanks with default data.
  def set_defaults
    plant_defaults = user.plant_guides.find_by(plant_type: self.plant_type)
    self.days_to_maturity = plant_defaults.days_to_maturity if days_to_maturity.nil?
    self.days_relative_to_frost_date = plant_defaults.days_relative_to_frost_date if days_relative_to_frost_date.nil?

    self.harvest_period = user.plant_guides.find_by(plant_type: plant_type).harvest_period
  end
end
