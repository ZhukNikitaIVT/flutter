import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/weather_model.dart';
import 'models/daylight_model.dart';
import 'models/duration_adapter.dart';

import 'api/weather_api.dart';
import 'cubit/weather_cubit.dart';
import 'cubit/daylight_cubit.dart';

import 'screens/weather_screen.dart';
import 'screens/developer_screen.dart';
import 'screens/daylight_calculator_screen.dart';
import 'screens/camera_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

 
  Hive.registerAdapter(WeatherModelAdapter());
  Hive.registerAdapter(DaylightModelAdapter());
  Hive.registerAdapter(DurationAdapter());

 
  await Hive.openBox<WeatherModel>('weather_history');
  await Hive.openBox<DaylightModel>('daylight_history');

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(OpenWeatherMapApi())..loadHistory(),
        ),
        BlocProvider(
          create: (context) => DaylightCubit()..loadHistory(),
        ),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const WeatherPage(),
          '/developer': (context) => const DeveloperPage(),
          '/daylight': (context) => const DaylightCalculatorPage(),
          '/camera': (context) => const CameraPage(),
        },
      ),
    );
  }
}