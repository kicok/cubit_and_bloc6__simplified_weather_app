import 'package:flutter/foundation.dart';
import 'package:flutter_weather_cubit6/models/weather.dart';
import 'weather_api_client.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(WeatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    print('city in getWeather :$city');
    final int locationId = await weatherApiClient.getLocationId(city);
    print('locationId : $locationId');
    return weatherApiClient.fetchWeather(locationId);
  }
}
