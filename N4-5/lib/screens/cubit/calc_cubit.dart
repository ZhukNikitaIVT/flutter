import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'calc_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitial());

  double _mass = 0;
  double _radius = 0;
  bool _agriment = false;

  List<List<double>> _history = [];

  void updateMass(double mass) {
    _mass = mass;
    emit(CalculatorUpdated(mass: _mass, radius: _radius, agriment: _agriment));
  }

  void updateRadius(double radius) {
    _radius = radius;
    emit(CalculatorUpdated(mass: _mass, radius: _radius, agriment: _agriment));
  }

  void toggleConsent(bool value) {
    _agriment = value;
    emit(CalculatorUpdated(mass: _mass, radius: _radius, agriment: _agriment));
  }

  void _saveToHistory(double mass, double radius, double acceleration) async {
      final prefs = await SharedPreferences.getInstance();
      List<String> historyStrings = prefs.getStringList('history') ?? [];
      historyStrings.add([mass, radius, acceleration].join(','));
      await prefs.setStringList('history', historyStrings);
  }

  void calculateGravity(double mass, double radius) async {
  if (mass > 0 && radius > 0 && _agriment) {
    const double G = 6.674 * 1e-11;
    final acceleration = G * mass / (radius * radius);

    _saveToHistory(mass, radius, acceleration);
    emit(CalculatorResult(acceleration: acceleration));
  }
}


  List<List<double>> get history => _history;
}