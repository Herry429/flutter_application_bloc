import 'package:equatable/equatable.dart';
import 'package:flutter_application_bloc/model/weather.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super();
}

abstract class WeatherIntial extends WeatherState {}

abstract class WeatherLoading extends WeatherState {}

abstract class WeatherLoded extends WeatherState {
  final Weather weather;
  WeatherLoded(this.weather) : super([weather]);
}
