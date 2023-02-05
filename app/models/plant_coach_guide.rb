class PlantCoachGuide < ApplicationRecord
  validates_presence_of :plant_type

  has_one :transplant_guide
  has_one :seed_guide
  has_one :harvest_guide

  after_create :create_complete_guide

  # A PlantCoachGuide contains SeedGuide, TransplantGuide, and HarvestGuide.
  # This gives the PlantCoachGuide all the information that is needed.
  def create_complete_guide
    seed_guide = SeedGuide.find_by(plant_type: self.plant_type)
    transplant_guide = TransplantGuide.find_by(plant_type: self.plant_type)
    harvest_guide = HarvestGuide.find_by(plant_type: self.plant_type)

    self.seed_guide = seed_guide
    self.transplant_guide =  transplant_guide
    self.harvest_guide =  harvest_guide
  end
end
