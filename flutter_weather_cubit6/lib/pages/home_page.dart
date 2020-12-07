import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_cubit6/cubits/weather_cubit.dart';

import 'search_page.dart';
import 'setting_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<void> _refreshCompleter;
  String city;

  @override
  void initState() {
    _refreshCompleter = Completer<void>();
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
              city = await Navigator.push(
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
        listener: (context, state) {
          // refesh할때 로딩상태로 계속 머무르며 에러가 있을때 아래 코드의 주석을 푼다.
          // 그런데 내가 할때는 아래의 코드가 있으나 없으나 refresh할때 에러가 없었음.
          // if (state.weather != null) {
          //   _refreshCompleter?.complete();
          //   _refreshCompleter = Completer();
          // }
        },
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
              onRefresh: () {
                if (city != null) {
                  BlocProvider.of<WeatherCubit>(context).fetchWeather(city);
                }
                return _refreshCompleter.future;
              },
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
