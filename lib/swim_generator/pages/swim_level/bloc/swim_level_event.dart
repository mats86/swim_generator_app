part of 'swim_level_bloc.dart';

abstract class SwimLevelEvent extends Equatable {
  const SwimLevelEvent();

  @override
  List<Object> get props => [];
}

class IsDirectLinks extends SwimLevelEvent {
  final bool isDirectLinks;
  const IsDirectLinks(this.isDirectLinks);

  @override
  List<Object> get props => [isDirectLinks];
}

class SwimLevelChanged extends SwimLevelEvent {
  final SwimLevelModel swimLevelModel;

  const SwimLevelChanged(this.swimLevelModel);

  @override
  List<Object> get props => [swimLevelModel];
}

class LoadSwimSeasonOptions extends SwimLevelEvent {
  final List<SwimSeason> swimSeasonOptions;

  const LoadSwimSeasonOptions(this.swimSeasonOptions);

  @override
  List<Object> get props => [swimSeasonOptions];
}

class LoadSwimLevelOptions extends SwimLevelEvent {
  final List<SwimLevelRadioButton> swimLevelOptions;

  const LoadSwimLevelOptions(this.swimLevelOptions);

  @override
  List<Object> get props => [swimLevelOptions];
}

class SwimSeasonChanged extends SwimLevelEvent {
  final String swimSeasonName;
  final SwimSeason season;
  final bool isDirectLinks;

  const SwimSeasonChanged(this.swimSeasonName, this.season, this.isDirectLinks);

  @override
  List<Object> get props => [swimSeasonName, season, isDirectLinks];
}

class SwimLevelRBChanged extends SwimLevelEvent {
  final String swimLevelName;
  final SwimLevelRadioButton swimLeveRB;

  const SwimLevelRBChanged(this.swimLevelName, this.swimLeveRB);

  @override
  List<Object> get props => [swimLevelName, swimLeveRB];
}

class SwimLevelOptionCheckboxChanged extends SwimLevelEvent {
  final SwimLevelRadioButton option;
  final bool isChecked;

  const SwimLevelOptionCheckboxChanged(this.option, this.isChecked);

  @override
  List<Object> get props => [option, isChecked];
}

class FormSubmitted extends SwimLevelEvent {}
