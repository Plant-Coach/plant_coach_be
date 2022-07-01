class Api::V1::AlertCheckController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    if request.headers['Auth'] == ENV['microservice_key']
      location_list = User.all_zip_codes.map do |location_data|
        {
          id: encode_token({ user_id: location_data.id }),
          zip: location_data.zip_code
        }
      end

      render json: AlertCheckSerializer.alert_check_list(location_list)
    end
  end
end
