require 'rails_helper'

RSpec.describe HarvestGuide, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:harvest_period) }
  end
  
  describe 'relationships' do
    it { should have_many(:harvest_coachings) }
    it { should have_many(:garden_plants).through(:harvest_coachings) }
  end
end
