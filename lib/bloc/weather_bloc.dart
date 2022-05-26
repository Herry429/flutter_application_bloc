import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:flutter_application_bloc/model/weather.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @Override
  WeatherState get InitialState => WeatherIntial();
  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      yield WeatherLoading();
      final weather = await _fetchWeatherFromFakeApi(event.cityName);
      yield WeatherLoded(weather);
    }
  }

  Future<Weather> _fetchWeatherFromFakeApi(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      return Weather(cityName: cityName,
      temperature: 20 + Random().nextInt(15) + Random().nextDouble());
    },);
  }
}
 