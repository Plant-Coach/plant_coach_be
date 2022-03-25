require 'rails_helper'

RSpec.describe 'Users API' do
  describe 'POST user' do
    it 'creates a new user' do
      body = { name: 'Joel Grant', email: 'joel@plantcoach.com', zip_code: '80121', password: '12345', password_confirmation: '12345' }
      post '/api/v1/users', params: body
      created_user = User.last

      expect(response).to be_successful
    end
  end
end
