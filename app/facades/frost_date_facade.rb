class FrostDateFacade
  def self.get_frost_dates(zip_code)
    frost_date_data = FrostDateService.get_frost_dates(zip_code)
    FrostDates.new(frost_date_data)
  end
end
