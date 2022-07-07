class GardenReminderSerializer
  include JSONAPI::Serializer
  def self.confirm
    {
      message: "Reminder sent."
    }
  end
end
