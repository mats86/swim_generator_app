import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../models/models.dart';

part 'kind_personal_info_event.dart';
part 'kind_personal_info_state.dart';

class KindPersonalInfoBloc
    extends Bloc<KindPersonalInfoEvent, KindPersonalInfoState> {

  KindPersonalInfoBloc()
      : super(const KindPersonalInfoState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<FirstNameUnfocused>(_onFirstNameUnfocused);
    on<LastNameChanged>(_onLastNameChanged);
    on<LastNameUnfocused>(_onLastNameUnfocused);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onFirstNameChanged(FirstNameChanged event,
      Emitter<KindPersonalInfoState> emit,) {
    final firstName = FirstNameModel.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([firstName, state.lastName]),
      ),
    );
  }

  void _onFirstNameUnfocused(FirstNameUnfocused event,
      Emitter<KindPersonalInfoState> emit,) {
    final firstName = FirstNameModel.dirty(state.firstName.value);
    emit(state.copyWith(
      firstName: firstName,
      isValid: Formz.validate([firstName, state.lastName]),
    ));
  }

  void _onLastNameChanged(LastNameChanged event,
      Emitter<KindPersonalInfoState> emit,) {
    final lastName = LastNameModel.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([state.firstName, lastName]),
      ),
    );
  }

  void _onLastNameUnfocused(LastNameUnfocused event,
      Emitter<KindPersonalInfoState> emit,) {
    final lastName = LastNameModel.dirty(state.lastName.value);
    emit(state.copyWith(
      lastName: lastName,
      isValid: Formz.validate([state.firstName, lastName]),
    ));
  }

  void _onFormSubmitted(FormSubmitted event,
      Emitter<KindPersonalInfoState> emit,) async {
    final firstName = FirstNameModel.dirty(state.firstName.value);
    final lastName = LastNameModel.dirty(state.lastName.value);
    emit(
      state.copyWith(
        firstName: firstName,
        lastName: lastName,
        isValid: Formz.validate([firstName, lastName]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      // await userRepository.updateKidsPersonalInfo(
      //   firstName: state.firstName.value,
      //   lastName: state.lastName.value,
      // );
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
