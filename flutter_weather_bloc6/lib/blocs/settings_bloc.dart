import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

abstract class SettingEvent extends Equatable {}

//event
class SettingToggleed extends SettingEvent {
  @override
  List<Object> get props => [];
}

//states
enum TemperatureUnit { celcius, fahrenheit }

class SettingState extends Equatable {
  final TemperatureUnit temperatureUnit;

  SettingState({@required this.temperatureUnit})
      : assert(temperatureUnit != null);

  @override
  List<Object> get props => [temperatureUnit];
}

//bloc
class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc()
      : super(
          SettingState(
            temperatureUnit: TemperatureUnit.celcius,
          ),
        );

  @override
  Stream<SettingState> mapEventToState(SettingEvent event) async* {
    if (event is SettingToggleed) {
      yield SettingState(
        temperatureUnit: state.temperatureUnit == TemperatureUnit.celcius
            ? TemperatureUnit.fahrenheit
            : TemperatureUnit.celcius,
      );
    }
  }
}
