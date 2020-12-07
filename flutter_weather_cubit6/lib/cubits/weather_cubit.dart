import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/weather_repository.dart';
import '../models/weather.dart';

class WeatherState extends Equatable {
  final bool loading;
  final Weather weather;
  final String error;

  WeatherState({
    this.loading,
    this.weather,
    this.error,
  });

  // Immutable 을 위한 JS의 Spread Operator와 비슷한
  // 아래와 같은 방식으로 Immutable 을 유지하기 때문에 time travel debugging이 가능
  WeatherState copyWith({
    bool loading,
    Weather weather,
    String error,
  }) {
    return WeatherState(
      loading: loading ?? this.loading,
      weather: weather ?? this.weather,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [loading, weather, error];
}

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;

  static WeatherState initialWeatherState = WeatherState();
  WeatherCubit({this.weatherRepository}) : super(initialWeatherState);

  void fetchWeather(String city) async {
    emit(state.copyWith(loading: true));

    try {
      final Weather weather = await weatherRepository.getWeather(city);
      print('weather in WeatherCubit : ${weather.toJson()}');

      emit(state.copyWith(
        loading: false,
        weather: weather,
        error: null,
      ));
    } catch (_) {
      emit(state.copyWith(
        loading: false,
        error: 'Can not fetch the weather of the $city',
      ));
    }
  }
}
