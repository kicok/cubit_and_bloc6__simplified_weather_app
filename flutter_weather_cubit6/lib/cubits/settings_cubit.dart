import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

enum TemperatureUnit { celcius, fahrenheit }

class SettingState extends Equatable {
  final TemperatureUnit temperatureUnit;

  SettingState({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  SettingState copyWith({TemperatureUnit temperatureUnit}) {
    return SettingState(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
    );
  }

  @override
  List<Object> get props => [temperatureUnit];
}

class SettingCubit extends Cubit<SettingState> {
  SettingCubit()
      : super(
          SettingState(
            temperatureUnit: TemperatureUnit.celcius,
          ),
        );

  void toggleTempUnit() {
    final newState = state.copyWith(
      temperatureUnit: state.temperatureUnit == TemperatureUnit.celcius
          ? TemperatureUnit.fahrenheit
          : TemperatureUnit.celcius,
    );
    print('toggleState : $newState');
    emit(newState);
  }
}
