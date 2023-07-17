require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
    it { should validate_presence_of(:days_to_maturity) }
    it { should validate_presence_of(:hybrid_status) }
    it { should validate_presence_of(:plant_type) }
    it { should validate_presence_of(:days_relative_to_frost_date) }
    it { should validate_inclusion_of(:organic).in_array([true, false]) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:garden_plants) }
  end

  describe '#get_harvest_data', :vcr do
    before(:each) do
      tomato_seed = SeedGuide.create(
      plant_type: "Tomato",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false
    )
    pepper_seed = SeedGuide.create(
      plant_type: "Pepper",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false
    )
    eggplant_seed = SeedGuide.create(
      plant_type: "Eggplant",
      seedling_days_to_transplant: 49,
      direct_seed_recommended: false
    )
    romaine_seed = SeedGuide.create(
      plant_type: "Romaine Lettuce",
      seedling_days_to_transplant: 14,
      direct_seed_recommended: true
    )
    green_bean_seed = SeedGuide.create(
      plant_type: "Green Bean",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true
    )
    radish_seed = SeedGuide.create(
      plant_type: "Radish",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true
      )
    romaine_seed = SeedGuide.create(
      plant_type: "Romaine Lettuce",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true
    )
    basil_seed = SeedGuide.create(
      plant_type: "Basil",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true
    )
    sproutingbroccolo_seed = SeedGuide.create(
      plant_type: "Sprouting Broccoli",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true
    )
    cilantro_seed = SeedGuide.create(
      plant_type: "Cilantro",
      seedling_days_to_transplant: 0,
      direct_seed_recommended: true
    )

    tomato_transplant = TransplantGuide.create(
      plant_type: "Tomato",
      days_to_maturity: 55,
      days_relative_to_frost_date: 14
    )
    pepper_transplant = TransplantGuide.create(
      plant_type: "Pepper",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    eggplant_transplant = TransplantGuide.create(
      plant_type: "Eggplant",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    romaine_transplant = TransplantGuide.create(
      plant_type: "Romaine Lettuce",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    green_bean_transplant =TransplantGuide.create(
      plant_type: "Green Bean",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    radish_transplant = TransplantGuide.create(
      plant_type: "Radish",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    romaine_transplant = TransplantGuide.create(
      plant_type: "Romaine Lettuce",
      days_to_maturity: 45,
      days_relative_to_frost_date: 14
    )
    basil_transplant = TransplantGuide.create(
      plant_type: "Basil",
      days_to_maturity: 41,
      days_relative_to_frost_date: 0
    )
    sprouting_broccoli_transplant = TransplantGuide.create(
      plant_type: "Sprouting Broccoli",
      days_to_maturity: 42,
      days_relative_to_frost_date: -14
    )
    cilantro_transplant = TransplantGuide.create(
      plant_type: "Cilantro",
      days_to_maturity: 35,
      days_relative_to_frost_date: 0
    )

    tomato_harvest = HarvestGuide.create(
      plant_type: "Tomato",
      harvest_period: "season_long"
    )
    pepper_harvest = HarvestGuide.create(
      plant_type: "Pepper",
      harvest_period: "season_long"
    )
    eggplant_harvest = HarvestGuide.create(
      plant_type: "Eggplant",
      harvest_period: "season_long"
    )
    romaine_harvest = HarvestGuide.create(
      plant_type: "Romaine Lettuce",
      harvest_period: "one_time"
    )
    green_bean_harvest = HarvestGuide.create(
      plant_type: "Green Bean",
      harvest_period: "season_long"
    )
    radish_harvest = HarvestGuide.create(
      plant_type: "Radish",
      harvest_period: "one_week"
    )
    basil_harvest = HarvestGuide.create(
      plant_type: "Basil",
      harvest_period: "three_week"
    )
    broccoli_harvest = HarvestGuide.create(
      plant_type: "Sprouting Broccoli",
      harvest_period: "four_week"
    )
    cilantro_harvest = HarvestGuide.create(
      plant_type: "Cilantro",
      harvest_period: "two_week"
    )
    
    
    end
    # Series of 'let blocks' that can not be placed above.
    let(:user) { User.create!(
      name: 'Joel Grant',
      email: 'joel@plantcoach.com',
      zip_code: '80121',
      password: '12345',
      password_confirmation: '12345'
      )
    }

    let(:tomato_plant) { user.plants.create!(
      plant_type: "Tomato",
      name: "Cherokee Purple"
      )
    }

    it 'can identify harvest periods for season long plants' do

      tomato_plant = user.plants.create(
        plant_type: "Tomato",
        name: "Cherokee Purple"
      )
    
      tomato_harvest_data = tomato_plant.get_harvest_data

      expect(tomato_harvest_data).to be_a HarvestGuide 
      expect(tomato_harvest_data.plant_type).to eq("Tomato")
      expect(tomato_harvest_data.harvest_period).to eq("season_long")
    end

    it 'can identify harvest periods for four-week-harvested plants' do
      romaine_plant = user.plants.create(
        plant_type: "Sprouting Broccoli",
        name: "Di Cicco"
      )

      romaine_harvest_data = romaine_plant.get_harvest_data

      expect(romaine_harvest_data).to be_a HarvestGuide 
      expect(romaine_harvest_data.plant_type).to eq("Sprouting Broccoli")
      expect(romaine_harvest_data.harvest_period).to eq("four_week")
    end

    it 'can identify harvest periods for three-week-harvested plants' do
      romaine_plant = user.plants.create(
        plant_type: "Basil",
        name: "Thai Towers"
      )

      romaine_harvest_data = romaine_plant.get_harvest_data

      expect(romaine_harvest_data).to be_a HarvestGuide 
      expect(romaine_harvest_data.plant_type).to eq("Basil")
      expect(romaine_harvest_data.harvest_period).to eq("three_week")
    end

    it 'can identify harvest periods for two-week-harvested plants' do
      romaine_plant = user.plants.create(
        plant_type: "Cilantro",
        name: "Santo"
      )

      romaine_harvest_data = romaine_plant.get_harvest_data

      expect(romaine_harvest_data).to be_a HarvestGuide 
      expect(romaine_harvest_data.plant_type).to eq("Cilantro")
      expect(romaine_harvest_data.harvest_period).to eq("two_week")
    end

    it 'can identify harvest periods for one-time-harvested plants' do
      romaine_plant = user.plants.create(
        plant_type: "Romaine Lettuce",
        name: "Chalupa"
      )

      romaine_harvest_data = romaine_plant.get_harvest_data

      expect(romaine_harvest_data).to be_a HarvestGuide 
      expect(romaine_harvest_data.plant_type).to eq("Romaine Lettuce")
      expect(romaine_harvest_data.harvest_period).to eq("one_time")
    end
  end
end
