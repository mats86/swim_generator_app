import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'swim_generator_state.dart';

class SwimGeneratorCubit extends Cubit<SwimGeneratorState> {
  SwimGeneratorCubit(this.stepperLength) : super(const SwimGeneratorState());
  final int stepperLength;

  void stepTapped(int tappedIndex) =>
      emit(SwimGeneratorState(activeStepperIndex: tappedIndex));

  void stepContinued() {
    if (state.activeStepperIndex < stepperLength - 1) {
      emit(
          SwimGeneratorState(activeStepperIndex: state.activeStepperIndex + 1));
    } else {
      emit(SwimGeneratorState(activeStepperIndex: state.activeStepperIndex));
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      emit(
          SwimGeneratorState(activeStepperIndex: state.activeStepperIndex - 1));
    } else {
      emit(SwimGeneratorState(activeStepperIndex: state.activeStepperIndex));
    }
  }
}
