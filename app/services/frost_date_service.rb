class FrostDateService
  def self.get_frost_dates(zip_code)
    conn = Faraday.new(url: ENV['PLANT_COACH_WEATHER_API_BASE_URL'],
                       params: { zip_code: zip_code })
    response = conn.get('/api/v1/frost')
    JSON.parse(response.body, symbolize_names: true)
  end
end
