class WeatherAlerterMailer < ApplicationMailer
  def inform(user, alert_list)
    @email = user.email
    @name = user.name
    @zip_code = user.zip_code
    @alerts = alert_list

    mail(
      reply_to: "test@plants.asdf",
      to: @email,
      subject: "#{@name}, you have a weather alert that affects your garden!"
    )
  end
end
