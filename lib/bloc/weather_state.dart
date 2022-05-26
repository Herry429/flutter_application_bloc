import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]) : super(props);
}

class WeatherIntial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoded extends WeatherState {
  final Weather weather;
  WeatherLoded(this.weather) : super([weather]);
}
