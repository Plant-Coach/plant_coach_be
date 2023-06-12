require 'rails_helper'

RSpec.describe SeedGuide, type: :model do
  describe 'validations' do
    # it { should validate_presence_of(:plant_type) }
    it { should validate_inclusion_of(:direct_seed_recommended).in_array([true, false]) }
    it { should validate_presence_of(:seedling_days_to_transplant) }
  end
  describe 'relationships' do
    it { should have_many(:seed_coachings) }
    it { should have_many(:garden_plants).through(:seed_coachings) }
  end
end
