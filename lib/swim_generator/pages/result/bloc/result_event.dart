part of 'result_bloc.dart';

abstract class ResultEvent extends Equatable {
  const ResultEvent();

  @override
  List<Object> get props => [];
}

class ResultLoading extends ResultEvent {
  final bool isBooking;
  const ResultLoading(this.isBooking);

  @override
  List<Object> get props => [isBooking];
}

class ConfirmedChanged extends ResultEvent {
  final bool isChecked;
  const ConfirmedChanged(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}

class CancellationChanged extends ResultEvent {
  final bool isChecked;
  const CancellationChanged(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}

class ConsentGDPRChanged extends ResultEvent {
  final bool isChecked;
  const ConsentGDPRChanged(this.isChecked);

  @override
  List<Object> get props => [isChecked];
}

class FormSubmitted extends ResultEvent {
  final CompleteSwimCourseBookingInput completeSwimCourseBookingInput;
  const FormSubmitted(this.completeSwimCourseBookingInput);

  @override
  List<Object> get props => [completeSwimCourseBookingInput];
}