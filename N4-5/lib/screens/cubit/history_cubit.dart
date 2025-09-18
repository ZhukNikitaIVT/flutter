import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryCubit extends Cubit<List<List<double>>> {
  HistoryCubit() : super([]) {
    loadHistory();
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? historyStrings = prefs.getStringList('history');

    if (historyStrings != null) {
      List<List<double>> history = historyStrings
          .map((string) => string.split(',').map((value) => double.parse(value)).toList())
          .toList();

      emit(history);
    } else {
      emit([]);
    }
  }
}