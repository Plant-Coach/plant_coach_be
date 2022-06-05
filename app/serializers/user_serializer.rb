class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :zip_code

  def self.error(error_message)
    {
      "error": error_message
    }
  end

  def self.delete(error_message)
    {
      "message": error_message
    }
  end
end
