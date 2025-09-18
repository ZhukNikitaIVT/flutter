import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/history_cubit.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История расчетов'),
      ),
      body: BlocBuilder<HistoryCubit, List<List<double>>>(
        builder: (context, history) {
          if (history.isEmpty) {
            return Center(
              child: Text('Нет данных для отображения'),
            );
          }

          return ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              final entry = history[index];
              final mass = entry[0];
              final radius = entry[1];
              final acceleration = entry[2];

              return ListTile(
                title: Text('Масса: $mass кг, Радиус: $radius м, Ускорение свободного падения: ${acceleration.toStringAsFixed(2)} м/с²'),
              );
            },
          );
        },
      ),
    );
  }
}