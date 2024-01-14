import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../models/birth_day_model.dart';

part 'birth_day_event.dart';

part 'birth_day_state.dart';

class BirthDayBloc extends Bloc<BirthDayEvent, BirthDayState> {

  BirthDayBloc() : super(const BirthDayState()) {
    on<BirthDayChanged>(_onBirthDayChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onBirthDayChanged(
    BirthDayChanged event,
    Emitter<BirthDayState> emit,
  ) {
    final birthDay = BirthDayModel.dirty(event.birthDay);
    // Aktualisieren Sie den Status basierend auf der Gültigkeit des Formulars
    emit(
      state.copyWith(
        birthDay: birthDay,
        isValid: Formz.validate([birthDay]),
      ),
    );
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<BirthDayState> emit,
  ) async {
    final birthDay = BirthDayModel.dirty(state.birthDay.value);
    emit(
      state.copyWith(
        birthDay: birthDay,
        isValid: Formz.validate([birthDay])
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      // await userRepository.updateBirthDay(
      //   birthDay: birthDay.value!,
      // );
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
