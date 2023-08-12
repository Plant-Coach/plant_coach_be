require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    # binding.pry;
    # it { should validate_uniqueness_of(:name).scoped_to(:plant_type).with_message("A '/\w/' plant named '/\w/' already exists for '/\w/'!") }
    # it { should validate_presence_of(:days_to_maturity) }
    it { should validate_presence_of(:hybrid_status) }
    # it { should validate_presence_of(:plant_type) }
    # it { should validate_presence_of(:days_relative_to_frost_date) }
    it { should validate_inclusion_of(:organic).in_array([true, false]) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:garden_plants) }
  end
end
