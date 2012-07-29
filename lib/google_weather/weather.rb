class GoogleWeather
  class Weather
    attr_accessor :location, :temp_f, :temp_c, :humidity, :icon, :wind_condition, :condition, :day_of_week, :low, :high

    def initialize(attributes={})
      attributes.each do |att, val|
        val = val.first["data"] if val.is_a?(Array) && val.first.has_key?("data")
        self.__send__("#{att}=", val) if self.respond_to?("#{att}=")
      end
    end

    %w(temp_f temp_c low high).each do |temp|
      define_method "#{temp}=" do |val|
        instance_variable_set("@#{temp}", val.to_i)
      end
    end

    def icon=(val)
      @icon = "http://www.google.com#{val}"
    end


  end
end