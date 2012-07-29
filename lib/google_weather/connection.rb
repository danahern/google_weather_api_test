require 'open-uri'
require 'xmlsimple'

class GoogleWeather
  class LocationInvalid < StandardError; end
  class Connection
    attr_accessor :response

    def initialize(location)
      @response = parse(location)
      raise LocationInvalid, "Invalid Location" if location_invalid?
      @response
    end

    def location_invalid?
      @response.nil? || 
      @response["weather"] && @response["weather"].is_a?(Array) && @response["weather"].first.has_key?("problem_cause")
    end

    def parse(location)
      begin
        XmlSimple.xml_in(open(url(location)))
      rescue SocketError => e
        nil
      end
    end

    def url(location)
      "http://www.google.com/ig/api?weather=#{URI.escape(location)}"
    end
  end
end