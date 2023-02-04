require 'rails_helper'

RSpec.describe TransplantCoaching, type: :model do
  describe 'relationships' do
    it { should belong_to(:garden_plant) }
    it { should belong_to(:transplant_guide) }
  end
end
