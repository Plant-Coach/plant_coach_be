require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe 'validations' do
    ActiveRecord::Base.skip_callbacks = true
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:plant_type) }
    # it { should validate_presence_of(:days_to_maturity) }
    it { should validate_presence_of(:hybrid_status) }
    it { should validate_presence_of(:days_relative_to_frost_date) }
    it { should validate_uniqueness_of(:name).scoped_to(:user_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end
end
