require 'spec_helper'
describe GoogleWeather::Weather do
  it "should accept a hash and set values" do
    weather = GoogleWeather::Weather.new(location: "Paris France", temp_f: "65", temp_c: "95")
    weather.location.should eql "Paris France"
    weather.temp_f.should eql 65
    weather.temp_c.should eql 95
  end

  it "should turn temperatures into integers" do
    weather = GoogleWeather::Weather.new(location: "Paris France", temp_f: "65", temp_c: "95", high: "44", low: "99")
    weather.temp_f.should eql 65
    weather.temp_c.should eql 95
    weather.high.should eql 44
    weather.low.should eql 99
  end

  it "should turn the icon into a full url" do
    weather = GoogleWeather::Weather.new(location: "Paris France", icon: "/ig/images/weather/mist.gif")
    weather.icon.should eql "http://www.google.com/ig/images/weather/mist.gif"
  end

  it "should display the attributes" do
    weather = GoogleWeather::Weather.new(location: "Paris France", temp_f: "65", temp_c: "95", high: "44", low: "99", icon: "/ig/images/weather/mist.gif")
    weather.attributes.should have(6).elements
    expected = {location: "Paris France", temp_f: 65, temp_c: 95, high: 44, low: 99, icon: "http://www.google.com/ig/images/weather/mist.gif"}
    weather.attributes.should eql expected
  end
end