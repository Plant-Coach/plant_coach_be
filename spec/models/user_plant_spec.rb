require 'rails_helper'

RSpec.describe UserPlant do
  describe 'validations' do
    it { should validate_presence_of(:start_from_seed) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:plant) }
  end
end
