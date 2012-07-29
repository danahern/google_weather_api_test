class GoogleWeather
  class Weather
    attr_accessor :location, :temp_f, :temp_c, :humidity, :icon, :wind_condition, :condition, :day_of_week, :low, :high

    # For new weather objects, accepts a hash of attributes and calls the = method on them so they can be overwritten
    def initialize(attributes={})
      attributes.each do |att, val|
        val = val.first["data"] if val.is_a?(Array) && val.first.has_key?("data")
        self.__send__("#{att}=", val) if self.respond_to?("#{att}=")
      end
    end

    # Meta methods to turn all temparatures into integers so they can be compared
    %w(temp_f temp_c low high).each do |temp|
      define_method "#{temp}=" do |val|
        instance_variable_set("@#{temp}", val.to_i)
      end
    end

    # Generates a full url for google icons from the relative path
    def icon=(val)
      @icon = "http://www.google.com#{val}"
    end

    def attributes
      {location: @location, temp_f: @temp_f, temp_c: @temp_c, humidity: @humidity, icon: @icon, wind_condition: @wind_condition, condition: @condition, day_of_week: @day_of_week, low: @low, high: @high}.reject{|a, b| b.nil? || b == ""}
    end
  end
end