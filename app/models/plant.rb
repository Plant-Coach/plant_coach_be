# Plants are considered records that each user wants to have in their personal
# database.
class Plant < ApplicationRecord
  # Plant records must be unique according to name, but only unique for those that
  # belong to each user, based on user_id.

  # Plant names should be unique, per plant type, per user.
  # ie... A user can only have two plants with the same name, if the plant types are different.
  # ie... If a plant of the same plant type does not already have the same name, a new one can be created.
  validates :name, presence: true, uniqueness: { 
    scope: [:plant_type, :user_id],
    message: ->(object, data) do
      "A #{object.plant_type} plant named #{object.name} already exists for #{object.user.name}!"
    end
  } #, null: false
  validates :plant_type, presence: { message: "'Plant Type' can not be blank!" } #, null: false
  validates :days_to_maturity, presence: { message: "'Days to Maturity' can not be blank!" } #, null: false
  validates :hybrid_status, presence: true #, null: false
  validates :days_relative_to_frost_date, presence: { message: "'Days Relative to Frost Date' can not be blank!" }
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
