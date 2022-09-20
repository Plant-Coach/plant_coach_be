require 'rails_helper'

RSpec.describe SeedAction, type: :model do
  # describe 'validations' do
  #   it { should validate_presence_of(:plant_name) }
  #   it { should validate_presence_of(:description) }
  # end

  describe 'relationships' do
    it { should belong_to(:seed_coaching) }
    it { should belong_to(:garden_plant) }
  end
end
