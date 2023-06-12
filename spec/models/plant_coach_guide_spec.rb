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

  describe '#create_complete_guide' do
    it 'attaches the necessary components that make up a plant_coach_guide' do
      SeedGuide.create(
        plant_type: "Tomato",
        seedling_days_to_transplant: 49,
        direct_seed_recommended: false,
        recommended_transplant_date: true,
        recommended_seed_start_date: true
      )
      TransplantGuide.create(
        plant_type: "Tomato",
        days_to_maturity: 45,
        days_relative_to_frost_date: 14
      )
      HarvestGuide.create(
        plant_type: "Tomato",
        harvest_period: "season_long"
      )

      tomato_guide = PlantCoachGuide.create!(
        plant_type: "Tomato"
      )

      expect(tomato_guide.seed_guide).to_not be(nil)
      expect(tomato_guide.transplant_guide).to_not be(nil)
      expect(tomato_guide.harvest_guide).to_not be(nil)
      expect(tomato_guide.seed_guide.plant_type).to eq("Tomato")
      expect(tomato_guide.transplant_guide.plant_type).to eq("Tomato")
      expect(tomato_guide.harvest_guide.plant_type).to eq("Tomato")
    end
  end
end
