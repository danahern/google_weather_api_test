# google_weather_api_test
Google API Gem Test


## Installation
```Ruby
gem 'google_weather', git: "git://github.com/danahern/google_weather_api_test"
```

## Usage
Create the object and gather the weather.

```Ruby
@google_weather = GoogleWeather.new("New York City")
```

Get the current conditions

```Ruby
@google_weather.current_conditions
```

```Ruby
@google_weather.current_conditions.temp_f #=> 78
```

```Ruby
@google_weather.current_conditions.condition #=> "Partly Cloudy"
```

To see the list of attributes for any type of weather:

```Ruby
@google_weather.current_conditions.attributes
```


To get the forecast for a particular day

```Ruby
@google_weather.mon
@google_weather.tue
@google_weather.wed
@google_weather.wed
@google_weather.thu
@google_weather.fri
@google_weather.sat
@google_weather.sun
```

To get the 4 day forecast 

```Ruby
@google_weather.forecasts
```
