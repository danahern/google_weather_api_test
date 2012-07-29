require 'google_weather/connection'
require 'google_weather/weather'

class GoogleWeather
  attr_accessor :location, :connection

  def initialize(location)
    @location = location
    @connection = GoogleWeather::Connection.new(location)
  end

  def weather
    @connection.response["weather"].first
  end

  def current_conditions
    GoogleWeather::Weather.new(weather["current_conditions"].first)
  end

  def forecast_conditions
    weather["forecast_conditions"]
  end

  def forecasts
    forecast_conditions.map do |condition|
      GoogleWeather::Weather.new(condition)
    end
  end

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
  
end