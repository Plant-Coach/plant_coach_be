require 'rails_helper'

RSpec.describe Seed, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:scientific_name) }
    it { should validate_presence_of(:direct_seed) }
    it { should validate_presence_of(:sewing_depth) }
    it { should validate_presence_of(:sewing_date) }
    it { should validate_presence_of(:days_to_transplant) }
    it { should validate_presence_of(:transplant_date) }
    it { should validate_presence_of(:germination_temp) }
  end
end
