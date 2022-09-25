require 'rails_helper'

RSpec.describe PlantingGuide, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:plant_type) }
    it { should validate_presence_of(:description) }
  end
end
