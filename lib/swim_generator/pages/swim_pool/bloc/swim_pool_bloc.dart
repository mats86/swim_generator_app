import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/pages/pages.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/fix_date.dart';
import '../models/fix_date_model.dart';
import '../models/models.dart';
import '../models/swim_pool.dart';

part 'swim_pool_event.dart';

part 'swim_pool_repository.dart';

part 'swim_pool_state.dart';

class SwimPoolBloc extends Bloc<SwimPoolEvent, SwimPoolState> {
  final SwimPoolRepository service;

  SwimPoolBloc(this.service) : super(const SwimPoolState()) {
    on<SwimPoolLoading>(_onSwimPoolLoading);
    on<LoadSwimPools>(_onLoadSwimPools);
    on<LoadFixDates>(_onLoadFixDates);
    on<SwimPoolOptionToggled>(_onSwimPoolOptionToggled);
    on<SelectFlexDate>(_onSelectFlexDate);
    on<SelectFixDate>(_onSelectFixDate);
    on<FixDateChanged>(_onFixDateChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onSwimPoolLoading(
      SwimPoolLoading event,
      Emitter<SwimPoolState> emit,
      ) {
    emit(state.copyWith(isBooking: event.isBooking));
  }

  void _onLoadSwimPools(
    LoadSwimPools event,
    Emitter<SwimPoolState> emit,
  ) async {
    emit(state.copyWith(loadingStatus: FormzSubmissionStatus.inProgress));
    try {
      var pools = await service.fetchSwimPools();
      emit(state.copyWith(
          swimPools: pools, loadingStatus: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(loadingStatus: FormzSubmissionStatus.failure));
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _onLoadFixDates(
    LoadFixDates event,
    Emitter<SwimPoolState> emit,
  ) async {
    emit(state.copyWith(loadingFixDates: FormzSubmissionStatus.inProgress));
    try {
      var fixDates = await service.loadFixDates();
      emit(state.copyWith(
          fixDates: fixDates, loadingFixDates: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(loadingFixDates: FormzSubmissionStatus.failure));
    }
  }

  void _onSwimPoolOptionToggled(
    SwimPoolOptionToggled event,
    Emitter<SwimPoolState> emit,
  ) {
    var newPools = List<SwimPool>.from(state.swimPools);
    var pool = newPools[event.index];

    // Update the selected pool with the new isSelected value
    newPools[event.index] = SwimPool(
        index: event.index,
        swimPoolID: pool.swimPoolID,
        swimPoolName: pool.swimPoolName,
        swimPoolAddress: pool.swimPoolAddress,
        swimPoolPhoneNumber: pool.swimPoolPhoneNumber,
        swimPoolOpeningTimes: pool.swimPoolOpeningTimes,
        swimPoolHasFixedDate: pool.swimPoolHasFixedDate,
        isSwimPoolVisible: pool.isSwimPoolVisible,
        isSelected: event.isSelected);

    // Check if any of the pools have swimPoolHasFixedDate set to true
    bool anyPoolHasFixedDate =
        newPools.any((p) => p.swimPoolHasFixedDate && p.isSelected);

    List<FixDate> newFixDates = [];
    newFixDates.addAll(state.fixDatesVisible);
    if (newPools[event.index].isSelected) {
      for (var fixDate in state.fixDates) {
        if (fixDate.swimPoolID == newPools[event.index].swimPoolID &&
            !newFixDates.any((existingItem) =>
                existingItem.fixDateID == fixDate.fixDateID)) {
          newFixDates.add(fixDate);
        }
      }
    } else {
      newFixDates.removeWhere(
          (element) => element.swimPoolID == newPools[event.index].swimPoolID);
    }
    // Validate the form
    final isValid = Formz.validate([SwimPoolModel.dirty(newPools)]) && !(state.flexFixDate);

    // Emit the new state with updated values
    emit(
      state.copyWith(
        swimPools: newPools,
        fixDatesVisible: newFixDates,
        hasFixedDate: anyPoolHasFixedDate,
        isValid: isValid,
      ),
    );
  }

  void _onSelectFlexDate(
      SelectFlexDate event, Emitter<SwimPoolState> emit) {
    final isValid = Formz.validate([SwimPoolModel.dirty(state.swimPools)]);
    emit(state.copyWith(
        flexFixDate: false, isValid: isValid));
  }

  void _onSelectFixDate(
      SelectFixDate event, Emitter<SwimPoolState> emit) {
    final isValid = Formz.validate([SwimPoolModel.dirty(state.swimPools)]) && (state.flexFixDate);
    emit(state.copyWith(
        flexFixDate: true, isValid: isValid));
  }

  void _onFixDateChanged(FixDateChanged event, Emitter<SwimPoolState> emit) {
    final fixDateModel = FixDateModel.dirty(event.fixDateName);
    emit(
      state.copyWith(
        fixDateModel: fixDateModel,
        selectedFixDate: event.fixDate,
        isValid: Formz.validate(
          [fixDateModel, SwimPoolModel.dirty(state.swimPools)],
        ),
      ),
    );
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<SwimPoolState> emit) async {
    final isValid = Formz.validate([SwimPoolModel.dirty(state.swimPools)]);
    if (isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        for (var swimPool in state.swimPools) {
          if (swimPool.isSelected) {
            // await userRepository.updateSwimPoolInfo(
            //     swimPoolID: swimPool.swimPoolID,
            //     swimPoolName: swimPool.swimPoolName);
          }
        }
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
