require 'rails_helper'

RSpec.describe TransplantGuide, type: :model do
  describe 'validations' do

  end

  describe 'relationships' do
    it { should have_many(:transplant_coachings) }
    it { should have_many(:garden_plants).through(:transplant_coachings) }
  end
end
