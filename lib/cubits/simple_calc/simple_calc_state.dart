part of 'simple_calc_cubit.dart';

abstract class SimpleCalcState extends Equatable {
  @override
  List<Object> get props => [];
}

class SimpleCalcCalculated extends SimpleCalcState {
  SimpleCalcCalculated(this.breakdown, this.totalChange);

  final Map<String, num> breakdown;
  final num totalChange;

  @override
  List<Object> get props => [breakdown, totalChange];
}
