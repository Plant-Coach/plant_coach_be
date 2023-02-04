class SeedCoaching < ApplicationRecord
  validates_presence_of :when_to_remind,
                        :remind
  belongs_to :seed_guide
  belongs_to :garden_plant
end
