require 'spec_helper'
describe GoogleWeather do
  describe "#initialize" do
    it "should initialize with a location" do
      VCR.use_cassette('google_paris') do
        weather = GoogleWeather.new('Paris France')
        weather.location.should eql "Paris France"
      end
    end

    it "should error with no location" do
      lambda {GoogleWeather.new}.should raise_error GoogleWeather::LocationMissing
    end

    it "should error with an invalid location" do
      VCR.use_cassette('google_neverland') do
        lambda {GoogleWeather.new("Neverland Make Believe")}.should raise_error GoogleWeather::LocationInvalid
      end
    end

    it "should create a connection to google" do
      VCR.use_cassette('google_paris') do
        weather = GoogleWeather.new('Paris France')
        weather.connection.should be_a_kind_of GoogleWeather::Connection
      end
    end
  end

  describe "#weather" do 
    it "should gather the weather objects from the response" do
      VCR.use_cassette('google_paris') do
        google_weather = GoogleWeather.new('Paris France')
        response = google_weather.connection.response["weather"].first
        google_weather.weather.should eql response
      end
    end
  end

  describe "meta_methods" do
    it "should create meta methods for the days of the week" do
      VCR.use_cassette('google_paris') do
        google_weather = GoogleWeather.new('Paris France')
        %w(sun mon tue wed thu fri sat).all?{|method| google_weather.respond_to?(method) }.should be_true
      end
    end

    it "should create weather objects for the days" do
      VCR.use_cassette('google_paris') do
        google_weather = GoogleWeather.new('Paris France')
        %w(sun mon tue wed thu fri sat).any?{|method| !google_weather.send(method).nil?}.should be_true
        %w(sun mon tue wed thu fri sat).any?{|method| google_weather.send(method).is_a?(GoogleWeather::Weather)}.should be_true
      end
    end
  end

  describe "forecasts" do
    it "should create an array of weather objects" do 
      VCR.use_cassette('google_paris') do
        google_weather = GoogleWeather.new('Paris France')
        google_weather.forecasts.should be_a Array
        google_weather.forecasts.all?{|forecast| forecast.is_a?(GoogleWeather::Weather)}
      end
    end
  end

  describe "#current_conditions" do
    it "should create a weather object with the current conditions" do
      VCR.use_cassette('google_paris') do
        google_weather = GoogleWeather.new('Paris France')
        google_weather.current_conditions.should be_a GoogleWeather::Weather
      end
    end
  end
end