require 'rails_helper'

RSpec.describe SeedGuide, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:germination_temp) }
    it { should validate_presence_of(:plant_type) }
    it { should validate_presence_of(:germination_temp) }
    it { should validate_inclusion_of(:needs_fertilization).in_array([true, false]) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:sewing_depth) }
    it { should validate_presence_of(:when_ready_for_transplant) }
    it { should validate_presence_of(:fertilization_frequency) }
    it { should validate_inclusion_of(:direct_seed_recommended).in_array([true, false]) }
    # it { should validate_presence_of(:recommended_transplant_date) }
    # it { should validate_presence_of(:recommended_seed_sewing_date) }
    it { should validate_presence_of(:needs_potting_up) }
  end
  describe 'relationships' do
    it { should have_many(:seed_coachings) }
    it { should have_many(:garden_plants).through(:seed_coachings) }
  end
end
