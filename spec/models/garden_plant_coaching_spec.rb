require 'rails_helper'

RSpec.describe GardenPlantCoaching, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:days_to_remind) }
  end
end
