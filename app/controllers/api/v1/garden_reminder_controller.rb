# Reminder the User can set up for themselves.
class Api::V1::GardenReminderController < ApplicationController
  # Skipped since this is available for a microservice and not a user request.
  skip_before_action :authorized, only: [:create]

  # Triggers a reminder email to be sent.
  def create
    return unless request.headers['Auth'] == ENV['microservice_key']

    # Intentionally commented out
    # request.headers['Alert'].each do |alert_payload|
    #   decoded_user = JWT.decode(alert_payload[:id], 'secret', true, algorithm: 'HS256')
    #   user = User.find(decoded_user[0]['user_id'])
    #   reminders = alert_payload[:reminder].map { |reminder| Reminder.new(reminder) }
    #   GardenReminderMailer.inform(user, reminders).deliver_now
    # end
    render json: GardenReminderSerializer.confirm
  end
end
