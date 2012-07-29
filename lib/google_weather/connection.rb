require 'xmlsimple'
require 'net/http'

class GoogleWeather
  class LocationInvalid < StandardError; end
  class Connection
    attr_accessor :response

    def initialize(location=nil)
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
        XmlSimple.xml_in(get(location).encode("UTF-8", "ISO-8859-1"))
      rescue SocketError => e
        nil
      end
    end

    def get(location)
      response = Net::HTTP.get_response(url(location))
      response.body if response.is_a?(Net::HTTPSuccess)
    end

    def url(location)
      URI("http://www.google.com/ig/api?weather=#{URI.escape(location)}")
    end
  end
end