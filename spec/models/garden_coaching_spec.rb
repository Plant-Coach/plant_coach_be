require 'rails_helper'

RSpec.describe GardenCoaching, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:days_to_remind) }
  end

  describe 'relationships' do
    it { should have_many(:users) }
    it { should have_many(:users).through(:user_garden_coachings) }
  end
end
