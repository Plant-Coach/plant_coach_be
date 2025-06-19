class ForecastMicroservice
  def self.forecast(zip_code)
    conn = Faraday.new(url: ENV['PLANT_COACH_WEATHER_API_BASE_URL'])
    response = conn.post('/api/v1/forecast') do |req|
      req.body = { "location": zip_code }
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
