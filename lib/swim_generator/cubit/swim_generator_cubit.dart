import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';

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
          true;

      emit(state.copyWith(
        activeStepperIndex: state.activeStepperIndex - 1,
        shouldUseFutureBuilderList: newList,
      ));
    }
  }

  void updateKindPersonalInfo(String? firstName, String? lastName) {
    emit(state.copyWith(
        kindPersonalInfo: state.kindPersonalInfo.copyWith(
      firstName: firstName,
      lastName: lastName,
    )));
  }

  void updateSwimLevel(SwimLevelEnum? swimLevel) {
    emit(state.copyWith(
        swimLevel: state.swimLevel.copyWith(swimLevel: swimLevel)));
  }

  void updateBirthDay(DateTime? birthDay) {
    emit(state.copyWith(birthDay: state.birthDay.copyWith(birthDay: birthDay)));
  }

  void updateSwimCourseInfo(SwimCourseInfo? swimCourseInfo) {
    emit(state.copyWith(swimCourseInfo: swimCourseInfo));
  }

  void updateSwimPoolInfo(List<SwimPoolInfo>? swimPoolInfo) {
    emit(state.copyWith(swimPools: swimPoolInfo));
  }
}
