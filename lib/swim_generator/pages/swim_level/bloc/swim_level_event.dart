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

class SwimSeasonChanged extends SwimLevelEvent {
  final String swimSeasonName;
  final SwimSeason season;
  final bool isDirectLinks;

  const SwimSeasonChanged(this.swimSeasonName, this.season, this.isDirectLinks);

  @override
  List<Object> get props => [swimSeasonName, season, isDirectLinks];
}

class FormSubmitted extends SwimLevelEvent {}
