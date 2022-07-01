class Alert
  attr_reader :id, :sender_name, :event, :start, :end, :description, :tags
  def initialize(data)
    @id = nil
    @sender_name = data[:sender_name]
    @event = data[:event]
    @start = data[:start]
    @end = data[:end]
    @description = data[:description]
    @tags = data[:tags]
  end
end
