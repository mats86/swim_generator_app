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
    on<ResultLoading>(_onResultLoading);
    on<ConfirmedChanged>(_onConfirmedChanged);
    on<CancellationChanged>(_onCancellationChanged);
    on<ConsentGDPRChanged>(_onConsentGDPRChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onResultLoading(
    ResultLoading event,
    Emitter<ResultState> emit,
  ) {
    emit(state.copyWith(isBooking: event.isBooking));
  }

  void _onConfirmedChanged(
    ConfirmedChanged event,
    Emitter<ResultState> emit,
  ) {
    final isConfirmed = CheckboxModel.dirty(event.isChecked);
    emit(state.copyWith(
      isConfirmed: isConfirmed,
      isValid: state.isBooking
          ? Formz.validate(
              [isConfirmed, state.isCancellation, state.isConsentGDPR])
          : Formz.validate([isConfirmed, state.isConsentGDPR]),
    ));
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
      isValid: state.isBooking
          ? Formz.validate(
              [state.isConfirmed, state.isCancellation, isConsentGDPR])
          : Formz.validate([state.isConfirmed, isConsentGDPR]),
    ));
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<ResultState> emit,
  ) async {
    final isConfirmed = CheckboxModel.dirty(state.isConfirmed.value);
    final isConsentGDPR = CheckboxModel.dirty(state.isConsentGDPR.value);
    if (state.isBooking) {
      emit(
        state.copyWith(
          isConfirmed: isConfirmed,
          isCancellation: CheckboxModel.dirty(state.isCancellation.value),
          isConsentGDPR: isConsentGDPR,
          isValid: Formz.validate([
            isConfirmed,
            CheckboxModel.dirty(state.isCancellation.value),
            isConsentGDPR
          ]),
        ),
      );
    } else {
      emit(
        state.copyWith(
          isConfirmed: isConfirmed,
          isConsentGDPR: isConsentGDPR,
          isValid: Formz.validate([isConfirmed, isConsentGDPR]),
        ),
      );
    }
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      if (event.isEmailExists) {
        await service.executeBookingForExistingGuardian(
          NewStudentAndBookingInput(
            loginEmail: event.completeSwimCourseBookingInput.loginEmail,
            studentFirstName:
                event.completeSwimCourseBookingInput.studentFirstName,
            studentLastName:
                event.completeSwimCourseBookingInput.studentLastName,
            studentBirthDate:
                event.completeSwimCourseBookingInput.studentBirthDate,
            swimCourseID: event.completeSwimCourseBookingInput.swimCourseID,
            swimPoolIDs: event.completeSwimCourseBookingInput.swimPoolIDs,
            referenceBooking:
                event.completeSwimCourseBookingInput.referenceBooking,
            fixDateID: event.completeSwimCourseBookingInput.fixDateID,
          ),
        );
      } else {
        await service.executeCreateCompleteSwimCourseBooking(
            event.completeSwimCourseBookingInput);
      }
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
