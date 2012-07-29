require 'xmlsimple'
require 'net/http'

class GoogleWeather
  class Connection
    attr_accessor :response

    # For new connections, do some error checking and set the response for parsing
    def initialize(location=nil)
      @response = parse(location)
      raise LocationInvalid, "Invalid Location" if location_invalid?
      @response
    end

    # Check to make sure the response is a valid response
    def location_invalid?
      @response.nil? || 
      @response["weather"] && @response["weather"].is_a?(Array) && @response["weather"].first.has_key?("problem_cause")
    end

    # Parse the response xml into a hash, and perform a character encoding change.
    def parse(location)
      begin
        XmlSimple.xml_in(get(location).encode("UTF-8", "ISO-8859-1"))
      rescue SocketError => e
        nil
      end
    end

    # The actual Net::HTTP lookup.  Catch timeout errors and raise special error
    def get(location)
      begin
        response = Net::HTTP.get_response(url(location))
        response.body if response.is_a?(Net::HTTPSuccess)
      rescue ::Timeout::Error
        raise GoogleWeather::Connection::Timeout, "The connection timed out, please try again later."
      end
    end

    # The url to do the lookups
    def url(location)
      URI("http://www.google.com/ig/api?weather=#{URI.escape(location)}")
    end

    # Timeout Error
    class Timeout < StandardError; end
  end
end