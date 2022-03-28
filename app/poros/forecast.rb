class Forecast
  attr_reader :id, :date, :sunrise, :sunset, :high, :low, :humidity, :wind, :weather
  def initialize(data)
    @id = data[:id]
    @date = format_date(data[:attributes][:date])
    @sunrise = format_datetime(data[:attributes][:sunrise])
    @sunset = format_datetime(data[:attributes][:sunset])
    @high = data[:attributes][:high]
    @low = data[:attributes][:low]
    @humidity = data[:attributes][:humidity]
    @wind = data[:attributes][:wind]
    @weather = data[:attributes][:weather]
  end

  def format_date(datetime)
    Time.at(datetime).to_date
  end

  def format_datetime(datetime)
    Time.at(datetime).strftime('%H:%M:%S')
  end
end
