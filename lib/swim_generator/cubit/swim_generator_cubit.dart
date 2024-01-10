import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'swim_generator_state.dart';

class SwimGeneratorCubit extends Cubit<SwimGeneratorState> {
  SwimGeneratorCubit(this.stepperLength)
      : super(SwimGeneratorState(
    shouldUseFutureBuilderList:
    List.generate(stepperLength, (index) => false),
  ));
  final int stepperLength;

  void stepTapped(int tappedIndex) {
    emit(SwimGeneratorState(
      activeStepperIndex: tappedIndex,
      shouldUseFutureBuilderList: state.shouldUseFutureBuilderList,
    ));
  }

  void stepContinued() {
    if (state.activeStepperIndex < stepperLength - 1) {
      var newList = List<bool>.from(state.shouldUseFutureBuilderList);
      // newList[state.activeStepperIndex + 1] = false; // Oder Ihren gewünschten Wert

      emit(state.copyWith(
        activeStepperIndex: state.activeStepperIndex + 1,
        shouldUseFutureBuilderList: newList,
      ));
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      var newList = List<bool>.from(state.shouldUseFutureBuilderList);
      newList[state.activeStepperIndex - 1] =
      true; // Oder Ihren gewünschten Wert

      emit(state.copyWith(
        activeStepperIndex: state.activeStepperIndex - 1,
        shouldUseFutureBuilderList: newList,
      ));
    }
  }
}
