require 'rails_helper'

RSpec.describe GardenUserCoaching, type: :model do
  describe 'relationships' do
    it { should belong_to(:garden_coaching) }
    it { should belong_to(:user) }
  end
end
