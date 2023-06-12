class TransplantGuide < ApplicationRecord
  validates_presence_of :days_to_maturity,
                        :days_relative_to_frost_date
                        
  has_many :transplant_coachings
  has_many :garden_plants, through: :transplant_coachings
end
