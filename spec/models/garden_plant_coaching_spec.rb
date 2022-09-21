require 'rails_helper'

RSpec.describe GardenPlantCoaching, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:days_to_remind) }
  end

  describe 'relationships' do
    it { should have_many(:garden_plant_actions) }
    it { should have_many(:garden_plants).through(:garden_plant_actions) }
  end
end
