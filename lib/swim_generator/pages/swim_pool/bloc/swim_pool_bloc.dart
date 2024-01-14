import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/fix_date.dart';
import '../models/models.dart';
import '../models/swim_pool.dart';

part 'swim_pool_event.dart';

part 'swim_pool_repository.dart';

part 'swim_pool_state.dart';

class SwimPoolBloc extends Bloc<SwimPoolEvent, SwimPoolState> {
  final SwimPoolRepository service;

  SwimPoolBloc(this.service) : super(const SwimPoolState()) {
    on<LoadSwimPools>(_onLoadSwimPools);
    on<LoadFixDates>(_onLoadFixDates);
    on<SwimPoolOptionToggled>(_onSwimPoolOptionToggled);
    on<SelectFlexDate>(_onSelectFlexDate);
    on<SelectFixDate>(_onSelectFixDate);
    on<FormSubmitted>(_onFormSubmitted);
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

    // Validate the form
    final isValid = Formz.validate([SwimPoolModel.dirty(newPools)]);

    // Emit the new state with updated values
    emit(state.copyWith(
        swimPools: newPools,
        hasFixedDate: anyPoolHasFixedDate,
        isValid: isValid));
  }

  void _onSelectFlexDate(
      SelectFlexDate event, Emitter<SwimPoolState> emit) async {
    emit(state.copyWith(flexFixDate: false));
  }

  void _onSelectFixDate(
      SelectFixDate event, Emitter<SwimPoolState> emit) async {
    emit(state.copyWith(flexFixDate: true));
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
