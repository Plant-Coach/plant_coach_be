class TransplantGuide < ApplicationRecord
  has_many :transplant_coachings
  has_many :garden_plants, through: :transplant_coachings
end
