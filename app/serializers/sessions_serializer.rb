class SessionsSerializer
  include JSONAPI::Serializer

  def self.error(error_message)
    {
      "error": error_message
    }
  end
end
