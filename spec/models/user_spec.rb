require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:spring_frost_dates).on(:update) }
    it { should validate_presence_of(:fall_frost_dates).on(:update) }
    it { should have_secure_password }
  end

  describe 'relationships' do
    it { should have_many(:plants) }
    it { should have_many(:garden_plants) }
  end
end
