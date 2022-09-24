class GardenCoaching < ApplicationRecord
  validates_presence_of :title, :description, :days_to_remind

  has_many :garden_user_coachings
  has_many :users, through: :garden_user_coachings
end
