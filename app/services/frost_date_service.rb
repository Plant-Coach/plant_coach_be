class FrostDateService
  def self.get_frost_dates(zip_code)
    conn = Faraday.new(url: 'https://glacial-fjord-58347.herokuapp.com',
                       params: { zip_code: zip_code })
    response = conn.get('/api/v1/frost')
    JSON.parse(response.body, symbolize_names: true)
  end
end
