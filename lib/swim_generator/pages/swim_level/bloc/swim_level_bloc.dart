import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../swim_course/models/swim_season_model.dart';
import '../models/swim_level_model.dart';
import '../models/swim_season.dart';

part 'swim_level_event.dart';

part 'swim_level_state.dart';

class SwimLevelBloc extends Bloc<SwimLevelEvent, SwimLevelState> {
  SwimLevelBloc() : super(const SwimLevelState()) {
    on<IsDirectLinks>(_onIsDirectLinks);
    on<SwimLevelChanged>(_onSwimLevelChanged);
    on<LoadSwimSeasonOptions>(_onLoadSwimSeasonOptions);
    on<SwimSeasonChanged>(_onSwimSeasonChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onIsDirectLinks(
      IsDirectLinks event,
    Emitter<SwimLevelState> emit,
  ) {
    emit(state.copyWith(isDirectLinks: event.isDirectLinks));
  }

  void _onSwimLevelChanged(
    SwimLevelChanged event,
    Emitter<SwimLevelState> emit,
  ) {
    final swimLevelModel = SwimLevelModel.dirty(event.swimLevelModel.value);

    emit(
      state.copyWith(
        swimLevelModel: swimLevelModel,
        isValid: Formz.validate([swimLevelModel, state.swimSeason]),
      ),
    );
  }

  void _onLoadSwimSeasonOptions(
      LoadSwimSeasonOptions event, Emitter<SwimLevelState> emit) {
    emit(state.copyWith(swimSeasonOptions: event.swimSeasonOptions));
  }

  void _onSwimSeasonChanged(
      SwimSeasonChanged event, Emitter<SwimLevelState> emit) {
    final swimSeason = SwimSeasonModel.dirty(event.swimSeasonName);
    emit(
      state.copyWith(
        swimSeason: swimSeason,
        selectedSwimSeason: event.season,
        isValid: event.isDirectLinks
            ? Formz.validate(
                [swimSeason],
              )
            : Formz.validate(
                [state.swimLevelModel, swimSeason],
              ),
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
        isValid: state.isDirectLinks
            ? Formz.validate(
          [state.swimSeason],
        )
            : Formz.validate(
          [swimLevelModel, state.swimSeason],
        ),
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      // await userRepository.updateSwimLevel(
      //   swimLevel: swimLevelModel.value!,
      // );
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
    }
  }
}
