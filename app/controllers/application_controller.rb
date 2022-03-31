class ApplicationController < ActionController::API
  def passwords_dont_match
    params[:password] != params[:password_confirmation]
  end

  def user_already_exists
    User.find_by(email: params[:email])
  end

  def email_formatted_incorrectly(user)
    user.errors.messages[:email]
  end
  def encode_token(payload)
    JWT.encode(payload, 'secret')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token(token)
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 'secret', true, algorith: 'HS256')

      rescue JWT::DecodeError
        nil
      end
    end
  end
end
