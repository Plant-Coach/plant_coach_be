class SeedCoaching < ApplicationRecord
  validates_presence_of :title, :description, :days_to_remind
  has_many :seed_actions
  has_many :garden_plants, through: :seed_actions
end
