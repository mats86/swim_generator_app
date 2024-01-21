part of 'swim_pool_bloc.dart';

abstract class SwimPoolEvent extends Equatable {
  const SwimPoolEvent();

  @override
  List<Object> get props => [];
}

class SwimPoolLoading extends SwimPoolEvent {
  final bool isBooking;
  const SwimPoolLoading(this.isBooking);

  @override
  List<Object> get props => [isBooking];
}

class LoadSwimPools extends SwimPoolEvent {}

class LoadFixDates extends SwimPoolEvent {}

class SwimPoolOptionToggled extends SwimPoolEvent {
  final int index;
  final bool isSelected;

  const SwimPoolOptionToggled(this.index, this.isSelected);
}

class SwimPoolModelsChanged extends SwimPoolEvent {
  final List<SwimPool> swimPools;

  const SwimPoolModelsChanged(this.swimPools);
}

class FixDateChanged extends SwimPoolEvent {
  final int fixDateName;
  final FixDate fixDate;
  const FixDateChanged(this.fixDateName, this.fixDate);

  @override
  List<Object> get props => [fixDateName, fixDate];
}

class SelectFlexDate extends SwimPoolEvent {}

class SelectFixDate extends SwimPoolEvent {}

class FormSubmitted extends SwimPoolEvent {}