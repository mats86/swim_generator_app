
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_course/models/swim_course.dart';
import 'package:user_repository/user_repository.dart';

import '../../../../graphql/graphql_queries.dart';
import '../models/models.dart';

part 'swim_course_event.dart';
part 'swim_course_repository.dart';

part 'swim_course_state.dart';

class SwimCourseBloc extends Bloc<SwimCourseEvent, SwimCourseState> {
  final SwimCourseRepository service;
  final UserRepository userRepository;

  SwimCourseBloc(this.service, this.userRepository)
      : super(const SwimCourseState()) {
    on<SwimSeasonChanged>(_onSwimSeasonChanged);
    on<SwimCourseChanged>(_onSwimCourseChanged);
    on<LoadSwimSeasonOptions>(_onLoadSwimSeasonOptions);
    on<LoadSwimCourseOptions>(_onLoadSwimCourseOptions);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onSwimSeasonChanged(
      SwimSeasonChanged event, Emitter<SwimCourseState> emit) {
    final swimSeason = SwimSeasonModel.dirty(event.swimSeason);
    emit(
      state.copyWith(
        swimSeason: swimSeason,
        isValid: Formz.validate(
          [swimSeason, state.swimCourse],
        ),
      ),
    );
  }

  void _onSwimCourseChanged(
      SwimCourseChanged event, Emitter<SwimCourseState> emit) {
    final swimCourse = SwimCourseModel.dirty(event.swimCourse);
    emit(
      state.copyWith(
        swimCourse: swimCourse,
        selectedCourse: event.course,
        isValid: Formz.validate(
          [state.swimSeason, swimCourse],
        ),
      ),
    );
  }

  void _onLoadSwimSeasonOptions(
      LoadSwimSeasonOptions event, Emitter<SwimCourseState> emit) async {
    emit(state.copyWith(loadingSeasonStatus: FormzSubmissionStatus.inProgress));
    try {
      final swimSeason = await service.fetchSwimSeason();
      emit(state.copyWith(
          swimSeasons: swimSeason,
          swimSeason: SwimSeasonModel.dirty(swimSeason[0]),
          loadingSeasonStatus: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(loadingSeasonStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onLoadSwimCourseOptions(
      LoadSwimCourseOptions event, Emitter<SwimCourseState> emit) async {
    emit(state.copyWith(loadingCourseStatus: FormzSubmissionStatus.inProgress));
    try {
      final user = await userRepository.getUser();
      if (user?.birthDay != null) {
        final swimCourses = await service.getSwimCoursesByLevelNameAndFutureAge(
            user!.swimLevel.swimLevelString, user.birthDay.birthDay!, DateTime(2024, 6, 1));
        emit(state.copyWith(
            swimCourseOptions: swimCourses,
            loadingCourseStatus: FormzSubmissionStatus.success));
      } else {
        emit(
            state.copyWith(loadingCourseStatus: FormzSubmissionStatus.failure));
      }
    } catch (e) {
      // Hier können Sie spezifische Fehler loggen
      print('Fehler beim Laden der Schwimmkurse: $e');
      emit(state.copyWith(loadingCourseStatus: FormzSubmissionStatus.failure));
    }
  }

  void _onFormSubmitted(
      FormSubmitted event, Emitter<SwimCourseState> emit) async {
    final inValid = Formz.validate([state.swimSeason, state.swimCourse]);
    if (inValid) {
      emit(state.copyWith(submissionStatus: FormzSubmissionStatus.inProgress));
      try {
        await userRepository.updateSwimCourseInfo(
          season: state.swimSeason.value,
          swimCourseID: state.selectedCourse.id,
          swimCourseName: state.selectedCourse.name,
          swimCoursePrice: state.selectedCourse.price.toString(),
        );
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(submissionStatus: FormzSubmissionStatus.failure));
      }
    }
  }
}
