import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0, ""));

  List<num> validDenominations = [200, 50, 20, 10, 5, 2, 1, 0.5, 0.2];

  void calculateWithMod(double cost, double tender) {
    num totalChange = tender - cost, tempChange = totalChange;
    Map<String, num> breakdown = {};

    try {
      for (var denomination in validDenominations) {
        if (denomination <= tempChange) {
          int amount = tempChange ~/ denomination;
          tempChange -= amount * denomination;

          breakdown.addAll({denomination.toString(): amount});
        }
      }

      // Success State
      emit(SimpleCalcCalculated(breakdown, totalChange, ""));
    } catch (e) {
      // Failed State
      emit(SimpleCalcCalculated({}, 0, e.toString()));
    }
  }

  void clearAll() {
    emit(SimpleCalcCalculated({}, 0, ""));
  }

  void textError() {
    emit(SimpleCalcCalculated({}, 0, "Make sure that the values entered are correct."));
  }
}
