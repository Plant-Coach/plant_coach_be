require 'rails_helper'

RSpec.describe 'Weather Alerts API Endpoints' do
  # Intentionally commented out to avoid emails being sent
  xdescribe 'POST /weather_alerts Endpoint' do
    it 'accepts a list of alerts and the users they belong to' do
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
        "alerts": [
          {
            "sender_name": "NWS Philadelphia - Mount Holly (New Jersey, Delaware, Southeastern Pennsylvania)",
            "event": "Small Craft Advisory",
            "start": 1646344800,
            "end": 1646380800,
            "description": "...SMALL CRAFT ADVISORY REMAINS IN EFFECT FROM 5 PM THIS\nAFTERNOON TO 3 AM EST FRIDAY...\n* WHAT...North winds 15 to 20 kt with gusts up to 25 kt and seas\n3 to 5 ft expected.\n* WHERE...Coastal waters from Little Egg Inlet to Great Egg\nInlet NJ out 20 nm, Coastal waters from Great Egg Inlet to\nCape May NJ out 20 nm and Coastal waters from Manasquan Inlet\nto Little Egg Inlet NJ out 20 nm.\n* WHEN...From 5 PM this afternoon to 3 AM EST Friday.\n* IMPACTS...Conditions will be hazardous to small craft.",
            "tags": [

            ]
          }
        ]
      }]
      post '/api/v1/weather_alerts', headers: { Auth: "qwerty", alert: body }

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      email = ActionMailer::Base.deliveries.last

      expect(email.subject).to eq("#{user3[:name]}, you have a weather alert that affects your garden!")
      expect(email.reply_to).to eq(['test@plants.asdf'])
      # result = JSON.parse(response.body, symbolize_names: true)
      # require 'pry'; binding.pry

    end

    it 'responds with a confirmation' do

    end
  end
end
