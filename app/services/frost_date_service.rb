class FrostDateService
  def self.get_frost_dates(zip_code)
    Rails.logger.info "Requesting frost dates for zip code: #{zip_code}"
    
    conn = Faraday.new(url: ENV['PLANT_COACH_WEATHER_API_BASE_URL'])
    response = conn.get('/api/v1/frost', { zip_code: zip_code })
    
    Rails.logger.info "Weather API response status: #{response.status}"
    Rails.logger.debug "Weather API response body: #{response.body}"
    
    if response.success?
      JSON.parse(response.body, symbolize_names: true)
    else
      Rails.logger.error "Weather API error: #{response.status} - #{response.body}"
      raise "Weather service returned #{response.status}"
    end
  rescue JSON::ParserError => e
    Rails.logger.error "JSON Parse Error: #{e.message}"
    Rails.logger.error "Response body was: #{response&.body}"
    raise "Failed to parse weather API response: #{e.message}"
  rescue StandardError => e
    Rails.logger.error "Frost Date Service Error: #{e.class} - #{e.message}"
    raise e
  end
end
