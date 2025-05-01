require 'rails_helper'

RSpec.describe GardenPlant, type: :model do
  describe 'validations' do
    ActiveRecord::Base.skip_callbacks = true

    subject { FactoryBot.build(:garden_plant) }
    it { should validate_inclusion_of(:direct_seed_recommended).in_array([true, false]) }
    it { should validate_presence_of(:plant_start_method) }
    it { should validate_presence_of(:planting_status) }
    # it { should validate_presence_of(:recommended_transplant_date) }
    # it { should validate_presence_of(:recommended_seed_sewing_date) }
    it { should validate_presence_of(:seedling_days_to_transplant) }
  end

  describe 'relationships' do
    it { should belong_to(:plant) }
  end
end
