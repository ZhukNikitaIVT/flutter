import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/nasa_cubit.dart';
import '/models/nasa.dart';
import 'cubit/nasa_state.dart';

class NasaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NASA Mars Photos'),
      ),
      body: BlocBuilder<NasaCubit, NasaState>(builder: (context, state) {
        // Состояние загрузки
        if (state is NasaLoadingState) {
          // Вызываем метод loadData() и показываем индикатор загрузки
          BlocProvider.of<NasaCubit>(context).loadData();
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        // Состояние ошибки
        else if (state is NasaErrorState) {
          // Показываем сообщение об ошибке
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Произошла ошибка",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // При нажатии кнопки перезагружаем данные
                    BlocProvider.of<NasaCubit>(context).loadData();
                  },
                  child: Text("Попробовать снова"),
                ),
              ],
            ),
          );
        }

        // Состояние успешной загрузки данных
        else if (state is NasaLoadedState) {
          // Отображаем список изображений
          return ListView.builder(
            itemCount: state.data.photos!.length,
            itemBuilder: (context, index) {
              final photo = state.data.photos![index];

              // Заменяем http на https
              final imageUrl = photo.imgSrc!.replaceAll('http://', 'https://');

              return Container(
                margin: EdgeInsets.all(8),
                height: 200,
                width: double.infinity,
                child: FadeInImage.assetNetwork(
                  placeholder: '', // Оставляем пустым, так как будем использовать placeholderFallback
                  image: imageUrl, // Используем обновленный URL
                  fit: BoxFit.cover,
                  imageErrorBuilder: (context, error, stackTrace) {
                    // Если произошла ошибка загрузки изображения, показываем текст
                    return Center(
                      child: Text(
                        'Произошла ошибка',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  },
                  placeholderErrorBuilder: (context, error, stackTrace) {
                    // Если произошла ошибка загрузки плейсхолдера, также показываем текст
                    return Center(
                      child: Text(
                        'Произошла ошибка',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }

        // По умолчанию показываем пустой экран
        else {
          return Center(
            child: Text("Неизвестное состояние"),
          );
        }
      }),
    );
  }
}