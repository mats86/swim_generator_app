part of 'birth_day_bloc.dart';

abstract class BirthDayEvent extends Equatable {
  const BirthDayEvent();

  @override
  List<Object> get props => [];
}

class BirthDayChanged extends BirthDayEvent {
  final DateTime birthDay;
  const BirthDayChanged(this.birthDay);

  @override
  List<Object> get props => [birthDay];
}

class FormSubmitted extends BirthDayEvent {}