import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'simple_calc_state.dart';

class SimpleCalcCubit extends Cubit<SimpleCalcState> {
  SimpleCalcCubit() : super(SimpleCalcCalculated({}, 0, ""));

  List<num> validDenominations = [200, 50, 20, 10, 5, 2, 1, 0.5, 0.2];

  void calculateWithMod(double cost, double tender) {
    num totalChange = tender - cost, tempChange = totalChange;
    Map<String, num> breakdown = {};
    String msg = "";

    try {
      // If tender is negative
      if (tender < 0) {
        msg = "The tender amount you entered was negative.";
        tender *= -1;
        totalChange = tender - cost;
        tempChange = totalChange;
      } else {
        // If tender is smaller than the cost amount.
        msg = (tender < cost)
            ? "Please check your amounts entered. The tender amount can't be smaller than the cost."
            : "";
      }

      for (var denomination in validDenominations) {
        if (denomination <= tempChange) {
          int amount = tempChange ~/ denomination;
          tempChange -= amount * denomination;

          breakdown.addAll({denomination.toString(): amount});
        }
      }

      msg = (tempChange > 0 && msg.isEmpty)
          ? "The rand note value was incorrect. Can't return: ${tempChange.toStringAsFixed(2)}c to client."
          : msg;

      // Success State
      emit(SimpleCalcCalculated(breakdown, totalChange, msg));
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
