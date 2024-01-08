part of 'swim_course_bloc.dart';

class SwimCourseState extends Equatable {
  const SwimCourseState({
    this.swimSeasons = const [],
    this.swimSeason = const SwimSeasonModel.pure(),
    this.swimCourseOptions = const [],
    this.swimCourse = const SwimCourseModel.pure(),
    this.selectedCourse = const SwimCourse.empty(),
    this.hasFixedDate = 0,
    this.isValid = false,
    this.loadingSeasonStatus = FormzSubmissionStatus.initial,
    this.loadingCourseStatus = FormzSubmissionStatus.initial,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final List<String> swimSeasons;
  final SwimSeasonModel swimSeason;
  final List<SwimCourse> swimCourseOptions;
  final SwimCourseModel swimCourse;
  final SwimCourse selectedCourse;
  final int hasFixedDate;
  final bool isValid;
  final FormzSubmissionStatus loadingSeasonStatus;
  final FormzSubmissionStatus loadingCourseStatus;
  final FormzSubmissionStatus submissionStatus;

  SwimCourseState copyWith({
    List<String>? swimSeasons,
    SwimSeasonModel? swimSeason,
    List<SwimCourse>? swimCourseOptions,
    SwimCourseModel? swimCourse,
    SwimCourse? selectedCourse,
    int? hasFixedDate,
    bool? isValid,
    FormzSubmissionStatus? loadingSeasonStatus,
    FormzSubmissionStatus? loadingCourseStatus,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimCourseState(
      swimSeasons: swimSeasons ?? this.swimSeasons,
      swimSeason: swimSeason ?? this.swimSeason,
      swimCourseOptions: swimCourseOptions ?? this.swimCourseOptions,
      swimCourse: swimCourse ?? this.swimCourse,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      hasFixedDate: hasFixedDate ?? this.hasFixedDate,
      isValid: isValid ?? this.isValid,
      loadingSeasonStatus: loadingSeasonStatus ?? this.loadingSeasonStatus,
      loadingCourseStatus: loadingCourseStatus ?? this.loadingCourseStatus,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props =>
      [
        swimSeasons,
        swimSeason,
        swimCourseOptions,
        swimCourse,
        hasFixedDate,
        loadingSeasonStatus,
        loadingCourseStatus,
        submissionStatus,
      ];
}
