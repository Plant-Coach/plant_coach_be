require 'rails_helper'

RSpec.describe HarvestCoaching, type: :model do
  describe 'relationships' do
    it { should belong_to(:garden_plant) }
    it { should belong_to(:harvest_guide) }
  end
end
