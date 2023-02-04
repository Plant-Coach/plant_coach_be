require 'rails_helper'

RSpec.describe SeedGuide, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:germination_temp) }
    it { should validate_presence_of(:growing_temp) }
    # it { should validate_presence_of(:days_to_transplant) }
    it { should validate_presence_of(:equipment_needed) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:sewing_depth) }
    # it { should validate_presence_of(:when_ready_for_transplant) }
    it { should validate_presence_of(:needs_fertilization) }
    # it { should validate_presence_of(:fertilization_frequency) }
    it { should validate_presence_of(:direct_seed_recommended) }
    # it { should validate_presence_of(:recommended_transplant_date) }
    # it { should validate_presence_of(:recommended_seed_sewing_date) }
    # it { should validate_presence_of(:needs_potting_up) }
    # it { should validate_presence_of(:potting_up_advice) }
  end
  describe 'relationships' do
    it { should have_many(:seed_coachings) }
    it { should have_many(:garden_plants).through(:seed_coachings) }
  end
end
