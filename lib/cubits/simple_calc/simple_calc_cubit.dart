import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0));

  List<num> validDenominations = [200, 50, 20, 10, 5, 2, 1, 0.5, 0.2];

  void calculateWithMod(double cost, double tender) {
    num totalChange = tender - cost;
    Map<String, num> breakdown = {};

    num tempChange = totalChange;

    for (var denomination in validDenominations) {
      if (denomination <= tempChange) {
        int amount = tempChange ~/ denomination;
        tempChange -= amount * denomination;

        breakdown.addAll({denomination.toString(): amount});
      }
    }

    emit(SimpleCalcCalculated(breakdown, totalChange));
  }

  void clearAll() {
    emit(SimpleCalcCalculated({}, 0));
  }
}
