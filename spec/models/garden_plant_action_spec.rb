require 'rails_helper'

RSpec.describe GardenPlantAction, type: :model do
  describe 'relationships' do
    it { should belong_to(:garden_plant_coaching) }
    it { should belong_to(:garden_plant) }
  end
end
