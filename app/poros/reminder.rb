class Reminder
  attr_reader :id, :reminder_type, :description
  def initialize(data)
    @id = nil
    @reminder_type = data[:reminder_type]
    @description = data[:description]
  end
end
