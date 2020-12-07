import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_cubit6/cubits/weather_cubit.dart';
import 'package:flutter_weather_cubit6/models/weather.dart';
import 'package:http/http.dart' as http;

import '../repositories/weather_api_client.dart';
import '../repositories/weather_repository.dart';
import 'search_page.dart';
import 'setting_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Weather'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsPage();
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              // search 의 검색 결과를 가져온다.
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
              print(city);
              if (city != null) {
                BlocProvider.of<WeatherCubit>(context).fetchWeather(city);
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state == WeatherCubit.initialWeatherState) {
            return Center(
              child: Text(
                'Select a city ',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          if (state.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.weather != null) {
            return RefreshIndicator(
              onRefresh: () {},
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 6),
                  Text(
                    state.weather.city,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${TimeOfDay.fromDateTime(state.weather.lastUpdated).format(context)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${state.weather.theTemp.toStringAsFixed(2)}℃',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        children: [
                          Text(
                            'Max: ${state.weather.maxTemp.toStringAsFixed(2)}℃',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'Min: ${state.weather.minTemp.toStringAsFixed(2)}℃',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    '${state.weather.weatherStateName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  )
                ],
              ),
            );
          }
          return Center(
            child: Text(
              state.error,
              style: TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
