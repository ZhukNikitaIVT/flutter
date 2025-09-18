import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screen/cubit/nasa_cubit.dart';
import 'screen/nasa_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NASA Mars Photos App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<NasaCubit>(
        create: (context) => NasaCubit(),
        child: NasaScreen(),
      ),
    );
  }
}