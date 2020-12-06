import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/weather.dart';

class WeatherApiClient {
  static const String baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

  // @required 어노테이션이 설정된 가변인자도 개발자가 파라미터를 입력하지 않으면 null로 채워지고 프로그램은 정상동작 된다.
  // 즉 어노테이션만으로는 강제할 수 없다는 것이다.
  // 가변인자를 강제로 입력하도록 하기 위해서는 어노테이션외에 추가로 assert 설정을 해주어야 한다.
  WeatherApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    final String url = '$baseUrl/api/location/search/?query=$city';
    final http.Response response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception('Can not get locationId of $city');
    }

    final responseBody = json.decode(response.body);

    if (responseBody.isEmpty) {
      throw Exception('The city you entered $city does not exist');
    }

    print('woeid: ${responseBody[0]['woeid']}');

    return responseBody[0]['woeid'];
  }

  Future<Weather> fetchWeather(int locationId) async {
    final url = '$baseUrl/api/location/$locationId';

    final http.Response response = await httpClient.get(url);

    if (response.statusCode != 200) {
      throw Exception(
          'Can not get weather of the city with locationId: $locationId');
    }

    final responseBody = json.decode(response.body);
    final Weather weather = Weather.fromJson(responseBody);
    print(weather.toJson());
    return weather;
  }
}
