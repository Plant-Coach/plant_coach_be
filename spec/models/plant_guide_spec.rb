require 'rails_helper'

RSpec.describe PlantGuide, type: :model do
  describe 'validations' do
    # it { should validate_presence_of(:plant_type) }
    # it { should validate_inclusion_of(:direct_seed_recommended).in_array([true, false]) }
    # it { should validate_presence_of(:seedling_days_to_transplant) }
    # it { should validate_presence_of(:days_to_maturity) }
    # it { should validate_presence_of(:days_relative_to_frost_date) }
    # it { should validate_presence_of(:harvest_period) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end
end
