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
end
