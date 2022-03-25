require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:latin_name) }
    it { should validate_presence_of(:days_to_maturity) }
    it { should validate_presence_of(:hybrid_status) }
    it { should validate_presence_of(:organic) }
    it { should validate_presence_of(:days_relative_to_frost_date) }
  end

  describe 'relationships' do
    it { should have_many(:user_plants) }
    it { should have_many(:users).through(:user_plants) }
  end
end
