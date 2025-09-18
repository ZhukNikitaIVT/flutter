import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/nasa_cubit.dart';
import 'nasa_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NasaScreenProvider extends StatelessWidget {
  const NasaScreenProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ConnectivityResult>(
      //future: Connectivity().checkConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Показываем индикатор загрузки, пока проверяется интернет
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.data == ConnectivityResult.none) {
          // Если нет интернета, показываем экран ошибки
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text("Нет подключения к интернету"),
              ),
            ),
          );
        }

        // Если интернет доступен, создаем BlocProvider
        return BlocProvider(
          create: (context) {
            final cubit = NasaCubit();
            cubit.loadData();
            return cubit;
          },
          child: NasaScreen(),
        );
      },
    );
  }
}