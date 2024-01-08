import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

import '../models/swim_level_model.dart';

part 'swim_level_event.dart';

part 'swim_level_state.dart';

class SwimLevelBloc extends Bloc<SwimLevelEvent, SwimLevelState> {
  final UserRepository userRepository;

  SwimLevelBloc({required this.userRepository}) : super(const SwimLevelState()) {
    on<SwimLevelChanged>(_onSwimLevelChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onSwimLevelChanged(
    SwimLevelChanged event,
    Emitter<SwimLevelState> emit,
  ) {
    final swimLevelModel = SwimLevelModel.dirty(event.swimLevelModel.value);

    emit(
      state.copyWith(
        swimLevelModel: swimLevelModel,
        isValid: Formz.validate([swimLevelModel]),
      ),
    );
  }

  void _onFormSubmitted(
    FormSubmitted event,
    Emitter<SwimLevelState> emit,
  ) async {
    final swimLevelModel = SwimLevelModel.dirty(state.swimLevelModel.value);
    emit(
      state.copyWith(
        swimLevelModel: swimLevelModel,
        isValid: Formz.validate([swimLevelModel]),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      await userRepository.updateSwimLevel(
        swimLevel: swimLevelModel.value!,
      );
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
