class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :zip_code, :spring_frost_date, :fall_frost_date

  def self.error(error_message)
    {
      "error": error_message
    }
  end

  def self.changes_not_saved(error, user)
    {
      "error": error,
      "user": user
    }
  end
end
