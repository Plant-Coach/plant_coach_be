class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :zip_code

  def self.error(error_message)
    {
      "error": error_message
    }
  end
end
