require 'google_weather/connection'
require 'google_weather/weather'

class GoogleWeather
  attr_accessor :location, :connection

  # GoogleWeather.new(location) raises an error if location is blank
  def initialize(location=nil)
    raise LocationMissing, "No location specified" if location.nil?
    @location = location
    @connection = GoogleWeather::Connection.new(location)
  end

  # Method to drill down the response to the weather section
  def weather
    @connection.response["weather"].first
  end

  # Gets the current weather conditions and turns them into a weather object
  def current_conditions
    GoogleWeather::Weather.new(weather["current_conditions"].first)
  end

  # Drills down into the forecst conditions from the weather drill down
  def forecast_conditions
    weather["forecast_conditions"]
  end

  # Gathers the forecasts and turns them into an array of weather objects
  def forecasts
    forecast_conditions.map do |condition|
      GoogleWeather::Weather.new(condition)
    end
  end

  # Meta methods for each day of the week, if google doesn't provide them then it will return nil, otherwise it returns a weather object.
  %w(sun mon tue wed thu fri sat).each do |day_of_week|
    define_method day_of_week do
      forecast = forecast_conditions.detect{|condition| condition["day_of_week"].first["data"].downcase == day_of_week}
      unless forecast.nil?
        GoogleWeather::Weather.new(forecast)
      else
        return nil
      end
    end
  end
  
  # Errors
  class LocationMissing < StandardError; end
  class LocationInvalid < StandardError; end
end