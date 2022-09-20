require 'rails_helper'

RSpec.describe SeedCoaching, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) } # Name of the coaching.
    it { should validate_presence_of(:description) } # Details of what the user should do.
    it { should validate_presence_of(:days_to_remind) } # Amount of time that should pass before this reminder is prompted.
  end
end
