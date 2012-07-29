require 'spec_helper'
describe GoogleWeather::Connection do
  describe "#initialize" do
    it "should error out with an invalid location" do
      VCR.use_cassette('google_neverland') do
        lambda{GoogleWeather::Connection.new("Neverland Make Believe")}.should raise_error GoogleWeather::LocationInvalid
      end
    end

    it "should set the response" do
      VCR.use_cassette('google_paris') do
        connection = GoogleWeather::Connection.new('Paris France')
        connection.response.should be_a Hash
        connection.response.should include "weather"
      end
    end  
  end

  describe "#parse" do
    it "should convert the response to a hash" do
      connection = VCR.use_cassette('google_paris') do
        GoogleWeather::Connection.new('Paris France')
      end
      VCR.use_cassette('google_paris') do
        parsed = connection.parse("Paris France")
        parsed.should be_a Hash
      end
    end
  end
end