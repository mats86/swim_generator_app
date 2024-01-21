import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/models.dart';
import '../pages/swim_level/models/models.dart';

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
      newList[state.activeStepperIndex - 1] = true;

      emit(state.copyWith(
        activeStepperIndex: state.activeStepperIndex - 1,
        shouldUseFutureBuilderList: newList,
      ));
    }
  }

  void updateSwimLevel(SwimLevelEnum? swimLevel, SwimSeason? swimSeason) {
    emit(state.copyWith(
        swimLevel: state.swimLevel.copyWith(
      swimLevel: swimLevel,
      swimSeason: swimSeason,
    )));
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

  void updateKindPersonalInfo(KindPersonalInfo? kindPersonalInfo) {
    emit(state.copyWith(kindPersonalInfo: kindPersonalInfo));
  }

  void updatePersonalInfo(PersonalInfo? personalInfo) {
    emit(state.copyWith(personalInfo: personalInfo));
  }
}
