import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/checkbox_model.dart';
import '../models/complete_swim_course_booking_input.dart';

part 'result_event.dart';

part 'result_repository.dart';

part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  final ResultRepository service;

  ResultBloc(this.service) : super(const ResultState()) {
    on<ConfirmedChanged>(_onConfirmedChanged);
    on<CancellationChanged>(_onCancellationChanged);
    on<ConsentGDPRChanged>(_onConsentGDPRChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onConfirmedChanged(
    ConfirmedChanged event,
    Emitter<ResultState> emit,
  ) {
    final isConfirmed = CheckboxModel.dirty(event.isChecked);
    emit(state.copyWith(
        isConfirmed: isConfirmed,
        isValid: Formz.validate(
            [isConfirmed, state.isCancellation, state.isConsentGDPR])));
  }

  void _onCancellationChanged(
    CancellationChanged event,
    Emitter<ResultState> emit,
  ) {
    final isCancellation = CheckboxModel.dirty(event.isChecked);
    emit(state.copyWith(
        isCancellation: isCancellation,
        isValid: Formz.validate(
            [state.isConfirmed, isCancellation, state.isConsentGDPR])));
  }

  void _onConsentGDPRChanged(
    ConsentGDPRChanged event,
    Emitter<ResultState> emit,
  ) {
    final isConsentGDPR = CheckboxModel.dirty(event.isChecked);
    emit(state.copyWith(
        isConsentGDPR: isConsentGDPR,
        isValid: Formz.validate(
            [state.isConfirmed, state.isCancellation, isConsentGDPR])));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<ResultState> emit,
  ) async {
    final isConfirmed = CheckboxModel.dirty(state.isConfirmed.value);
    final isCancellation = CheckboxModel.dirty(state.isCancellation.value);
    final isConsentGDPR = CheckboxModel.dirty(state.isConsentGDPR.value);
    emit(
      state.copyWith(
        isConfirmed: isConfirmed,
        isCancellation: isCancellation,
        isConsentGDPR: isConsentGDPR,
        isValid: Formz.validate([isConfirmed, isCancellation, isConsentGDPR]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      // final user = await userRepository.getUser();
      // var bookingInput = CompleteSwimCourseBookingInput(
      //   loginEmail: user!.personalInfo.email,
      //   guardianFirstName: user.personalInfo.firstName,
      //   guardianLastName: user.personalInfo.lastName,
      //   guardianAddress: '${user.personalInfo.streetNumber}'
      //       '${user.personalInfo.streetNumber}, '
      //       '${user.personalInfo.zipCode} '
      //       '${user.personalInfo.city}',
      //   guardianPhoneNumber: user.personalInfo.phoneNumber,
      //   studentFirstName: user.kidsPersonalInfo.firstName,
      //   studentLastName: user.kidsPersonalInfo.lastName,
      //   studentBirthDate: user.birthDay.birthDay!,
      //   swimCourseId: user.swimCourseInfo.swimCourseID,
      //   swimPoolIDs: user.swimPools.map((pool) => pool.swimPoolID).toList(),
      //   referenceBooking: '',
      // );
      // await service.executeCreateCompleteSwimCourseBooking(bookingInput);
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
