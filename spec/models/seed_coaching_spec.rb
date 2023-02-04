require 'rails_helper'

RSpec.describe SeedCoaching, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:when_to_remind) }
    it { should validate_presence_of(:remind) }
  end
  
  describe 'relationships' do
    it { should belong_to(:seed_guide) }
    it { should belong_to(:garden_plant) }
  end
end
