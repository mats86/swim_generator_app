part of 'swim_pool_bloc.dart';

abstract class SwimPoolEvent {}

class LoadSwimPools extends SwimPoolEvent {}

class LoadFixDates extends SwimPoolEvent {}

class SwimPoolOptionToggled extends SwimPoolEvent {
  final int index;
  final bool isSelected;

  SwimPoolOptionToggled(this.index, this.isSelected);
}

class SwimPoolModelsChanged extends SwimPoolEvent {
  final List<SwimPool> swimPools;

  SwimPoolModelsChanged(this.swimPools);
}

class SelectFlexDate extends SwimPoolEvent {}

class SelectFixDate extends SwimPoolEvent {}

class FormSubmitted extends SwimPoolEvent {}