class UserPlant < ApplicationRecord
  validates_presence_of :start_from_seed

  belongs_to :user
  belongs_to :plant
end
