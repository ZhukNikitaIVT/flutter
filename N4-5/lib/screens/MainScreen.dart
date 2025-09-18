import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/calc_cubit.dart';
import 'cubit/calc_state.dart';
import 'cubit/history_cubit.dart';
import 'HistoryScreen.dart';

class MainScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  double mass = 0.0;
  double radius = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выполнил: Жук Никита ИВТ-22'),
        leading: IconButton(
          icon: Icon(Icons.history),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => HistoryCubit(), // Убираем передачу CalculatorCubit
                  child: HistoryScreen(),
                ),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<CalculatorCubit, CalculatorState>(
          builder: (context, state) {
            bool agriment = state is CalculatorUpdated ? state.agriment : false;

            if (state is CalculatorInitial || state is CalculatorUpdated) {
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Масса небесного тела: ',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        mass = double.tryParse(value) ?? 0;
                        context.read<CalculatorCubit>().updateMass(mass);
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Пожалуйста, введите массу небесного тела';
                        final mass = double.tryParse(value);
                        if (mass == null || mass < 0) {
                          return 'Поле может содержать только положительные числа';
                        }
                        return null;
                      },
                    ),
                    const Text(
                      'Радиус небесного тела: ',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        radius = double.tryParse(value) ?? 0;
                        context.read<CalculatorCubit>().updateRadius(radius);
                      },
                      validator: (value) {
                        if (value!.isEmpty) return 'Пожалуйста, введите радиус небесного тела';
                        final rad = double.tryParse(value);
                        if (rad == null || rad < 0) {
                          return 'Поле может содержать только положительные числа';
                        }
                      },
                    ),
                    CheckboxListTile(
                      value: agriment,
                      title: Text('Я согласен на обработку данных'),
                      onChanged: (value) {
                        context.read<CalculatorCubit>().toggleConsent(value ?? false);
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (!agriment) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Вы должны согласиться с условиями обработки персональных данных.')),
                            );
                          } else {
                            context.read<CalculatorCubit>().calculateGravity(mass, radius);
                          }
                        }
                      },
                      child: Text('Посчитать ускорение свободного падения'),
                    ),
                  ],
                ),
              );
            } else if (state is CalculatorResult) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Ускорение свободного падения:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      '${state.acceleration.toStringAsFixed(2)} м/с²',
                      style: TextStyle(fontSize: 70.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<CalculatorCubit>().emit(CalculatorInitial());
                      },
                      child: Text('Вернуться на экран расчёта'),
                    ),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}