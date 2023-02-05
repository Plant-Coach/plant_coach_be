require 'rails_helper'

RSpec.describe PlantCoachGuide, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:plant_type) }
  end

  describe 'relationships' do
    it { should have_one(:transplant_guide) }
    it { should have_one(:seed_guide) }
    it { should have_one(:harvest_guide) }
  end
end
