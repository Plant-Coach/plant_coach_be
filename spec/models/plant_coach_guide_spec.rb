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
      SeedGuide.create!(
        plant_type: "Tomato",
        germination_temp: 80,
        sewing_depth: "1/8",
        when_ready_for_transplant: "4-8 Weeks",
        needs_fertilization: true,
        fertilization_frequency: "1x/week",
        direct_seed_recommended: false,
        needs_potting_up: true,
        description: "DEMO TOMATO SEED GUIDE TEXT"
      )
      TransplantGuide.create!(
        plant_type: "Tomato",
        growth_habit: "Vining or Bush",
        spacing: "2'",
        depth: "1/8",
        recommended_tools: "Shovel, water, fish fertilizer, supports",
        sun_requirements: "Full",
        description: "DEMO TOMATO TRANSPLANT TEXT"
      )
      HarvestGuide.create!(
        plant_type: "Tomato",
        when: 55,
        how: "ongoing",
        harvest_time: "Fruit is red"
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
