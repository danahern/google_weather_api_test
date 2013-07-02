# google_weather_api_test
Google API Gem

## What is this
This is a code challenge, the goal was to spend a few hours and write a gem using TDD practices using the now disabled Google Weather API.
Unfortunately because the google services no longer work, it's use a code demo.  The tests still pass because the VCR result is saved into the repository.

Stats
```Text
Test Coverage: 96.09%
Lines of Code: 123 (tested) / 128 (total)
Time Spent: 4 hours
```


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
