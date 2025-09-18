import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Лабораторная работа №2.\nВыполнил: Жук Никита ИВТ-22'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Container(
            color: Colors.red,
            width: 250,
            height: 200,
          ),),
        Container(
          alignment: Alignment.topRight,
          child: Container(
            color: Colors.green,
            width: 300,
            height: 300,
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: Colors.blue,
            width: 100,
            height: 100,
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: Container(
            color: const Color.fromARGB(255, 243, 219, 33),
            width: 100,
            height: 200,
          ),
        ),
      ],
    );
  }
}