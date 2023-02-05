class HarvestCoaching < ApplicationRecord
  belongs_to :garden_plant
  belongs_to :harvest_guide
end
