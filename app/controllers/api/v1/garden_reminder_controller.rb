class Api::V1::GardenReminderController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    if request.headers['Auth'] == ENV['microservice_key']
      request.headers['Alert'].each do |alert_payload|
        decoded_user = JWT.decode(alert_payload[:id], 'secret', true, algorithm: 'HS256')
        user = User.find(decoded_user[0]['user_id'])
        reminders = alert_payload[:reminder].map { |reminder| Reminder.new(reminder) }
        GardenReminderMailer.inform(user, reminders).deliver_now
      end
    end
  end
end
