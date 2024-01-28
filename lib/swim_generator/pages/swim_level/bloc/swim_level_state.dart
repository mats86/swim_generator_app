part of 'swim_level_bloc.dart';

class SwimLevelState extends Equatable {
  const SwimLevelState({
    this.isDirectLinks = false,
    this.swimLevelModel = const SwimLevelModel.pure(),
    this.swimSeasonOptions = const [],
    this.swimSeason = const SwimSeasonModel.pure(),
    this.selectedSwimSeason = const SwimSeason.empty(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool isDirectLinks;
  final SwimLevelModel swimLevelModel;
  final List<SwimSeason> swimSeasonOptions;
  final SwimSeasonModel swimSeason;
  final SwimSeason selectedSwimSeason;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  SwimLevelState copyWith({
    bool? isDirectLinks,
    SwimLevelModel? swimLevelModel,
    List<SwimSeason>? swimSeasonOptions,
    SwimSeasonModel? swimSeason,
    SwimSeason? selectedSwimSeason,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimLevelState(
      isDirectLinks: isDirectLinks ?? this.isDirectLinks,
      swimLevelModel: swimLevelModel ?? this.swimLevelModel,
      swimSeasonOptions: swimSeasonOptions ?? this.swimSeasonOptions,
      swimSeason: swimSeason ?? this.swimSeason,
      selectedSwimSeason: selectedSwimSeason ?? this.selectedSwimSeason,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [
        isDirectLinks,
        swimLevelModel,
        swimSeasonOptions,
        swimSeason,
        selectedSwimSeason,
        submissionStatus,
      ];
}
