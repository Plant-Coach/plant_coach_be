class SessionsSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :zip_code

  def self.error(error_message)
    {
      "error": error_message
    }
  end
end
