import 'dart:ffi';
import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_application_bloc/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sample App",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: WeatherPage(),
    );
  }
}

class WeatherPage extends StatelessWidget {
  final weatherbloc = WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: BlocProvider(
        bloc: weatherbloc,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocBuilder(
              bloc: WeatherBloc(),
              builder: (BuildContext context, WeatherState state) {
                if (state is WeatherIntial) {
                  return buildInitialInput();
                } else if (state is WeatherLoading) {
                  return buildLoading();
                } else if (state is WeatherLoded) {
                  return buildColumnWithData(state.weather);
                }
              }),
        ),
      ),
    );
  }

  Widget buildLoading() {}
}

Widget buildInitialInput() {
  return Center(
    child: CityIputField(),
  );
}

Widget builLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

class buildcolumn extends StatelessWidget {
  const buildcolumn({
    Key? key,
  }) : super(key: key);

  get weatherBloc => null;

  @override
  Widget build(BuildContext context) {
    var weather;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          weather.cityName,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          "${weather.temperature.toStringAsFixed(1)} C",
          style: TextStyle(
            fontSize: 80,
          ),
        ),
      ],
    );
  }

  @Override
  void dispose() {
    super.dispose();
    weatherBloc.dispose();
  }
}

class CityInputField {}

class CityIputField extends StatefulWidget {
  CityIputField({Key? key}) : super(key: key);

  @override
  State<CityIputField> createState() => _CityIputFieldState();
}

class _CityIputFieldState extends State<CityIputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: submitCityName,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}

void submitCityName(String cityName) {
  final weatherBloc = BlockProvider.of<WeatherBloc>(context);

  weatherBloc.dispatch(GetWeather(cityName));
}

mixin BlockProvider {
}
