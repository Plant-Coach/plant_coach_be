class Api::V1::WeatherAlertsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    if request.headers['Auth'] == ENV['microservice_key']
      request.headers['Alert'].each do |alert_payload|
        decoded_user = JWT.decode(alert_payload[:id], 'secret', true, algorithm: 'HS256')
        user = User.find(decoded_user[0]['user_id'])
        alerts = alert_payload[:alerts].map { |alert| Alert.new(alert) }
        WeatherAlerterMailer.inform(user, alerts).deliver_now
      end
    end
  end
end
