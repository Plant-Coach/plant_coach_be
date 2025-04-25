class Api::V1::AlertCheckController < ApplicationController
  # The Create action does not involve an authenticated user.
  skip_before_action :authorized, only: [:create]
  # This is triggered when a microservice checks for weather alerts for all
  # of the users in the application.
  def create
    return unless request.headers['Auth'] == ENV['microservice_key']

    # Get a list of all user zip codes to provide for the weather microservice
    # so that it can look for major weather events.
    location_list = User.all_zip_codes.map do |location_data|
      {
        id: encode_token({ user_id: location_data.id }),
        zip: location_data.zip_code
      }
    end

    # The list is returned to the microservice in a JSON response.
    render json: AlertCheckSerializer.alert_check_list(location_list)
  end
end
