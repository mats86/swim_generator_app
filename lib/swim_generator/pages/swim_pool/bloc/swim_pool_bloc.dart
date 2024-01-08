import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/models.dart';
import '../models/swim_pool.dart';

part 'swim_pool_event.dart';

part 'swim_pool_repository.dart';

part 'swim_pool_state.dart';

class SwimPoolBloc extends Bloc<SwimPoolEvent, SwimPoolState> {
  final SwimPoolRepository service;
  final UserRepository userRepository;

  SwimPoolBloc(this.service, this.userRepository)
      : super(const SwimPoolState()) {
    on<LoadSwimPools>(_onLoadSwimPools);
    on<SwimPoolOptionToggled>(_onSwimPoolOptionToggled);
    on<SwimPoolModelsChanged>(_onSwimPoolModelsChanged);
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

  void _onSwimPoolOptionToggled(
    SwimPoolOptionToggled event,
    Emitter<SwimPoolState> emit,
  ) {
    var newPools = List<SwimPool>.from(state.swimPools);
    var pool = newPools[event.index];
    newPools[event.index] = SwimPool(
        swimPoolID: pool.swimPoolID,
        swimPoolName: pool.swimPoolName,
        swimPoolAddress: pool.swimPoolAddress,
        swimPoolPhoneNumber: pool.swimPoolPhoneNumber,
        swimPoolOpeningTimes: pool.swimPoolOpeningTimes,
        isSelected: event.isSelected);
    final isValid = Formz.validate([SwimPoolModel.dirty(newPools)]);
    emit(state.copyWith(swimPools: newPools, isValid: isValid));
  }

  void _onSwimPoolModelsChanged(
    SwimPoolModelsChanged event,
    Emitter<SwimPoolState> emit,
  ) {
    final swimPoolModels = SwimPoolModel.dirty(event.swimPools);
    emit(state.copyWith(
      swimPoolModel: swimPoolModels,
      isValid: Formz.validate([swimPoolModels])
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<SwimPoolState> emit) async {
    final isValid = Formz.validate([SwimPoolModel.dirty(state.swimPools)]);
    if (isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        for (var swimPool in state.swimPools) {
          if (swimPool.isSelected) {
            await userRepository.updateSwimPoolInfo(
                swimPoolID: swimPool.swimPoolID,
                swimPoolName: swimPool.swimPoolName);
          }
        }
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
