import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../graphql/graphql_queries.dart';
import '../model/model.dart';

part 'date_selection_event.dart';

part 'date_selection_repository.dart';

part 'date_selection_state.dart';

class DateSelectionBloc extends Bloc<DateSelectionEvent, DateSelectionState> {
  final DateSelectionRepository service;

  DateSelectionBloc(this.service) : super(const DateSelectionState()) {
    on<LoadFixDates>(_onLoadFixDates);
    on<UpdateHasFixedDesiredDate>(_onUpdateHasFixedDesiredDate);
    on<SelectFlexDate>(_onSelectFlexDate);
    on<SelectFixDate>(_onSelectFixDate);
    on<FixDateChanged>(_onFixDateChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onLoadFixDates(
    LoadFixDates event,
    Emitter<DateSelectionState> emit,
  ) async {
    emit(state.copyWith(loadingFixDates: FormzSubmissionStatus.inProgress));
    try {
      var fixDates = await service.loadFixDates(event.swimCourseID, event.swimPoolIDs);
      emit(state.copyWith(
          fixDates: fixDates, loadingFixDates: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(loadingFixDates: FormzSubmissionStatus.failure));
    }
  }

  void _onUpdateHasFixedDesiredDate(
    UpdateHasFixedDesiredDate event,
    Emitter<DateSelectionState> emit,
  ) {
    emit(state.copyWith(hasFixedDesiredDate: event.hasFixedDesiredDate));
  }

  void _onSelectFlexDate(
      SelectFlexDate event, Emitter<DateSelectionState> emit) {
    emit(state.copyWith(flexFixDate: false, isValid: true));
  }

  void _onSelectFixDate(SelectFixDate event, Emitter<DateSelectionState> emit) {
    final isValid = (state.flexFixDate);
    emit(state.copyWith(flexFixDate: true, isValid: false));
  }

  void _onFixDateChanged(
      FixDateChanged event, Emitter<DateSelectionState> emit) {
    final fixDateModel = FixDateModel.dirty(event.fixDateName);
    emit(
      state.copyWith(
        fixDateModel: fixDateModel,
        selectedFixDate: event.fixDate,
        isValid: Formz.validate(
          [fixDateModel],
        ),
      ),
    );
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<DateSelectionState> emit) async {
    if (true) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
