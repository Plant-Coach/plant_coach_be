class GardenUserCoaching < ApplicationRecord
  belongs_to :user
  belongs_to :garden_coaching
end
