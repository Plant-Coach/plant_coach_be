require 'rails_helper'

RSpec.describe 'Garden Reminder API Endpoints' do
  describe 'POST /garden_reminder Endpoint' do
    # Intentionally commented out to avoid emails being sent
    it 'allows an email reminder to be triggered and sent to a user' do
      user1 = {
        name: 'Joel Grant1',
        email: 'joel1@plantcoach.com',
        zip_code: '80123',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: user1

      user2 = {
        name: 'Joel Grant2',
        email: 'joel2@plantcoach.com',
        zip_code: '80124',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: user2

      user3 = {
        name: 'Joel Grant3',
        email: 'joel3@plantcoach.com',
        zip_code: '80125',
        password: '12345',
        password_confirmation: '12345'
      }
      post '/api/v1/users', params: user3
      login_data = JSON.parse(response.body, symbolize_names: true)

      body = [{
        id: login_data[:jwt],
        "reminder": [
          {
            "reminder_type": "maintenance",
            "description": "You need to add compost to your garden!"
          }
        ]
      }]
      post '/api/v1/garden_reminder', headers: { Auth: ENV['microservice_key'], alert: body }
      result = JSON.parse(response.body, symbolize_names: true)

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      email = ActionMailer::Base.deliveries.last

      expect(email.subject).to eq("#{user3[:name]}, you have a reminder to do!")
      expect(email.reply_to).to eq(['test@plants.asdf'])

      expect(result).to have_key(:message)
      expect(result[:message]).to eq("Reminder sent.")
    end

    it 'responds with a confirmation' do

    end
  end
end
