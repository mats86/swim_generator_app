import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swim_generator_app/swim_generator/models/config_app.dart';

import '../models/models.dart';
import '../pages/swim_level/models/models.dart';

part 'swim_generator_state.dart';

class SwimGeneratorCubit extends Cubit<SwimGeneratorState> {
  SwimGeneratorCubit(this.stepperLength) : super(const SwimGeneratorState());
  final int stepperLength;

  void stepTapped(int tappedIndex) {
    emit(SwimGeneratorState(
      activeStepperIndex: tappedIndex,
    ));
  }

  void stepContinued() {
    if (state.activeStepperIndex < stepperLength - 1) {
      emit(state.copyWith(
        activeStepperIndex: state.activeStepperIndex + 1,
      ));
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      emit(state.copyWith(
        activeStepperIndex: state.activeStepperIndex - 1,
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

  void updateConfigApp({
    bool? isStartFixDate,
    bool? isBooking,
    bool? isDirectLinks,
    bool? isEmailExists,
  }) {
    emit(
      state.copyWith(
        configApp: state.configApp.copyWith(
          isStartFixDate: isStartFixDate ?? state.configApp.isStartFixDate,
          isBooking: isBooking ?? state.configApp.isBooking,
          isDirectLinks: isDirectLinks ?? state.configApp.isDirectLinks,
          isEmailExists: isEmailExists ?? state.configApp.isEmailExists,
        ),
      ),
    );
  }
}
