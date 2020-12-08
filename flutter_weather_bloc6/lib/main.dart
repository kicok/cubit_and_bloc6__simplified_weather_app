import 'package:flutter/material.dart';
import 'package:flutter_weather_bloc6/blocs/settings_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_bloc6/blocs/weather_bloc.dart';
import 'package:flutter_weather_bloc6/repositories/weather_api_client.dart';
import 'package:flutter_weather_bloc6/repositories/weather_repository.dart';

import 'pages/home_page.dart';

void main() {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
    httpClient: http.Client(),
  ));
  runApp(MyApp(
    weatherRepository: weatherRepository,
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const MyApp({Key key, this.weatherRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),
        ),
        BlocProvider(
          create: (context) => SettingBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
