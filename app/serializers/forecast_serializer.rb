class ForecastSerializer
  include JSONAPI::Serializer
  attributes :id, :date, :sunrise, :sunset, :high, :low, :humidity, :wind, :weather
end
