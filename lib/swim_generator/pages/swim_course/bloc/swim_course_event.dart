part of 'swim_course_bloc.dart';

abstract class SwimCourseEvent extends Equatable {
  const SwimCourseEvent();

  @override
  List<Object> get props => [];
}

class SwimCourseChanged extends SwimCourseEvent {
  final String swimCourse;
  final SwimCourse course;
  const SwimCourseChanged(this.swimCourse, this.course);

  @override
  List<Object> get props => [swimCourse, course];
}

class SwimSeasonChanged extends SwimCourseEvent {
  final String swimSeason;
  const SwimSeasonChanged(this.swimSeason);

  @override
  List<Object> get props => [swimSeason];
}

class LoadSwimSeasonOptions extends SwimCourseEvent {}

class LoadSwimCourseOptions extends SwimCourseEvent {
  final DateTime birthDay;
  final DateTime refDate;
  const LoadSwimCourseOptions(this.birthDay, this.refDate);

  @override
  List<Object> get props => [birthDay, refDate];
}

class FormSubmitted extends SwimCourseEvent {}
