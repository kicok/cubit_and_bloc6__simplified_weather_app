import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: BlocBuilder<SettingCubit, SettingState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(left: 10, top: 20, right: 10),
            child: ListTile(
              title: Text('Temperature Unit'),
              subtitle: Text('Celcius or Farenheit\nDefault: Celcius'),
              trailing: Switch(
                value: state.temperatureUnit == TemperatureUnit.celcius,
                onChanged: (_) {
                  BlocProvider.of<SettingCubit>(context).toggleTempUnit();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
