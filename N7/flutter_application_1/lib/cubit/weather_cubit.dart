import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../models/weather_model.dart';
import '../api/weather_api.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherApi w_api;
  late final Box<WeatherModel> historyBox;

  WeatherCubit(this.w_api) : super(WeatherInitial()) {
    historyBox = Hive.box<WeatherModel>('weather_history');
  }

  Future<void> getWeather(String city) async {
    emit(WeatherLoading());
    try {
      final weather = await w_api.getWeather(city);
      await historyBox.add(weather);
      emit(WeatherLoaded(weather));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<void> loadHistory() async {
    emit(WeatherHistoryLoading());
    try {
      final history = historyBox.values.toList().reversed.toList();
      emit(WeatherHistoryLoaded(history));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    historyBox.close();
    return super.close();
  }
}

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;

  const WeatherLoaded(this.weather);

  @override
  List<Object> get props => [weather];
}

class WeatherHistoryLoading extends WeatherState {}

class WeatherHistoryLoaded extends WeatherState {
  final List<WeatherModel> history;

  const WeatherHistoryLoaded(this.history);

  @override
  List<Object> get props => [history];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}