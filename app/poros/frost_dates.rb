class FrostDates
  attr_reader :id, :zip_code, :location_name, :lat, :lon, :spring_frost, :fall_frost

  def initialize(data)
    @id = nil
    @zip_code = data[:data][:attributes][:zip_code]
    @location_name = data[:data][:attributes][:location_name]
    @lat = data[:data][:attributes][:lat]
    @lon = data[:data][:attributes][:lon]
    @spring_frost = data[:data][:attributes][:spring_frost]
    @fall_frost = data[:data][:attributes][:fall_frost]
  end
end
