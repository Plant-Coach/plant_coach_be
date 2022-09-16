class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :zip_code, :spring_frost_dates, :fall_frost_dates

  def self.error(error_message)
    {
      "error": error_message
    }
  end
end
