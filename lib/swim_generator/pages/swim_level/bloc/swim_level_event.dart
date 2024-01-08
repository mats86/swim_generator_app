part of 'swim_level_bloc.dart';

abstract class SwimLevelEvent extends Equatable {
  const SwimLevelEvent();

  @override
  List<Object> get props => [];
}

class SwimLevelChanged extends SwimLevelEvent {
  final SwimLevelModel swimLevelModel;
  const SwimLevelChanged(this.swimLevelModel);

  @override
  List<Object> get props => [swimLevelModel];
}

class FormSubmitted extends SwimLevelEvent {}