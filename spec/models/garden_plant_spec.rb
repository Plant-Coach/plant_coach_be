require 'rails_helper'

RSpec.describe GardenPlant, type: :model do
  describe 'validations' do
    ActiveRecord::Base.skip_callbacks = true

    subject { FactoryBot.build(:garden_plant) }
    it { should validate_uniqueness_of(:name).scoped_to(:plant_id) }
    it { should validate_presence_of(:plant_type) }
    it { should validate_presence_of(:days_to_maturity) }
    it { should validate_presence_of(:hybrid_status) }
    it { should validate_inclusion_of(:organic).in_array([true, false]) }
    it { should validate_inclusion_of(:direct_seed_recommended).in_array([true, false]) }
    it { should validate_presence_of(:seed_sew_type) }
    it { should validate_inclusion_of(:start_from_seed).in_array([true, false]) }
    it { should validate_presence_of(:planting_status) }
    it { should validate_presence_of(:recommended_transplant_date) }
    it { should validate_presence_of(:recommended_seed_sewing_date) }
    it { should validate_presence_of(:seedling_days_to_transplant) }
    it { should validate_presence_of(:days_relative_to_frost_date) }
  end

  describe 'relationships' do
    it { should belong_to(:plant) }
    it { should have_many(:transplant_coachings) }
    it { should have_many(:transplant_guides).through(:transplant_coachings) }
    it { should have_many(:seed_coachings) }
    it { should have_many(:seed_guides).through(:seed_coachings) }
    it { should have_many(:harvest_coachings) }
    it { should have_many(:harvest_guides).through(:harvest_coachings) }
  end
end
