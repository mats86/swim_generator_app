part of 'date_selection_bloc.dart';

abstract class DateSelectionEvent extends Equatable {
  const DateSelectionEvent();

  @override
  List<Object> get props => [];
}

class LoadFixDates extends DateSelectionEvent {
  final int swimCourseID;
  final List<int> swimPoolIDs;

  const LoadFixDates(this.swimCourseID, this.swimPoolIDs);

  @override
  List<Object> get props => [swimCourseID, swimPoolIDs];
}

class FixDateChanged extends DateSelectionEvent {
  final int fixDateName;
  final FixDate fixDate;
  const FixDateChanged(this.fixDateName, this.fixDate);

  @override
  List<Object> get props => [fixDateName, fixDate];
}

class UpdateHasFixedDesiredDate extends DateSelectionEvent {
  final bool hasFixedDesiredDate;
  const UpdateHasFixedDesiredDate(this.hasFixedDesiredDate);

  @override
  List<Object> get props => [hasFixedDesiredDate];
}

class SelectFlexDate extends DateSelectionEvent {}

class SelectFixDate extends DateSelectionEvent {}

class FormSubmitted extends DateSelectionEvent {}