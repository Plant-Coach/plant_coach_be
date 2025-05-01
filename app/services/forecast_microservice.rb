class ForecastMicroservice
  def self.forecast(zip_code)
    conn = Faraday.new(url: 'https://glacial-fjord-58347.herokuapp.com')
    response = conn.post('/api/v1/forecast') do |req|
      req.body = { "location": zip_code }
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
