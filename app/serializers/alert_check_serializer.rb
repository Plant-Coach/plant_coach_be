class AlertCheckSerializer
  include JSONAPI::Serializer
  attributes :id, :zip

  def self.alert_check_list(location_data)
    location_data
  end
end
