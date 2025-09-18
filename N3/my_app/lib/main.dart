

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SecondScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
         title: const Text(
            '          Калькулятор ускорения \n'
            '          свободного падения\n'
            '          Выполнил: Жук Никита ИВТ-22',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
         ),
        ),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _massController = TextEditingController(); // Масса планеты (M)
  final _radiusController = TextEditingController(); // Радиус планеты (R)
  bool _agreement = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            const Text(
              'Введите массу планеты (кг)',
              style: TextStyle(fontSize: 16.0),
            ),
            TextFormField(
              controller: _massController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              validator: (value) {
                if (value!.isEmpty) return 'Пожалуйста введите массу!';
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Введите радиус планеты (м)',
              style: TextStyle(fontSize: 16.0),
            ),
            TextFormField(
              controller: _radiusController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              validator: (value) {
                if (value!.isEmpty) return 'Пожалуйста введите радиус!';
                return null;
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            CheckboxListTile(
              value: _agreement,
              title: const Text(
                'Согласны ли вы с использованием калькулятора ускорения свободного падения?',
                style: TextStyle(fontSize: 10.0),
              ),
              onChanged: (bool? value) => setState(() => _agreement = value!),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_agreement) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          mass: double.parse(_massController.text),
                          radius: double.parse(_radiusController.text),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Вы не согласились с условиями!'),
                      ),
                    );
                  }
                }
              },
              child: const Text('Рассчитать ускорение'),
            ),
          ],
        ),
      ),
    );
  }
}
