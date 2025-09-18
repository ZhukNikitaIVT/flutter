abstract class CalculatorState {
  get radius => null;

  get mass => null;
}

class CalculatorInitial extends CalculatorState {}

class CalculatorUpdated extends CalculatorState {
  final double mass;
  final double radius;
  final bool agriment;

  CalculatorUpdated({required this.mass, required this.radius, this.agriment = false});
}


class CalculatorResult extends CalculatorState {
  final double acceleration;

  CalculatorResult({required this.acceleration});
}