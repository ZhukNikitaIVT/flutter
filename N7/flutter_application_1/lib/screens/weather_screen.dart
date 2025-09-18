import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/weather_cubit.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => showHistory(context),
            child: const Text('История'),
          ),
          const SizedBox(width: 16),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/developer'),
            child: const Text('Справка'),
          ),
        ],
      ),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          WeatherSearch(),
          const SizedBox(height: 20),
          BlocBuilder<WeatherCubit, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return const CircularProgressIndicator();
              } else if (state is WeatherLoaded) {
                return WeatherInfo.WeatherInfo(weather: state.weather);
              } else if (state is WeatherError) {
                return Text(state.message);
              }
              return const SizedBox();
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/daylight'),
            child: const Text('Расчёт длины дня'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/camera'),
            child: const Text('Сделать фотографию неба'),
          ),
        ],
      ),
    ),
  );
}

  void showHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WeatherHistoryLoaded) {
              return AlertDialog(
                title: const Text('История'),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.history.length,
                    itemBuilder: (context, index) {
                      final item = state.history[index];
                      return ListTile(
                        title: Text(item.city),
                        subtitle: Text('${item.temperature}°C - ${item.description}'),
                        trailing: Text(
                          '${item.date.day}/${item.date.month}/${item.date.year}',
                        ),
                      );
                    },
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Закрыть'),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}

class WeatherSearch extends StatefulWidget {
  @override
  State<WeatherSearch> createState() => WeatherSearchState();
}

class WeatherSearchState extends State<WeatherSearch> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Введите город (на англ с большой)',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              context.read<WeatherCubit>().getWeather(controller.text);
            }
          },
        ),
      ],
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final WeatherModel weather;

  const WeatherInfo.WeatherInfo({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              weather.city,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              '${weather.temperature}°C',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
            Text(
              weather.description,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Последнее обновление: ${weather.date.hour}:${weather.date.minute}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}