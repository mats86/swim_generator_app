part of 'swim_level_bloc.dart';

class SwimLevelState extends Equatable {
  const SwimLevelState({
    this.isDirectLinks = false,
    this.swimLevelModel = const SwimLevelModel.pure(),
    this.swimSeasonOptions = const [],
    this.swimLevelOptions = const [],
    this.swimSeason = const SwimSeasonModel.pure(),
    this.swimLevelRB = const SwimSeasonModel.pure(),
    this.selectedSwimSeason = const SwimSeason.empty(),
    this.selectedSeimLevelRB = const SwimLevelRadioButton.empty(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final bool isDirectLinks;
  final SwimLevelModel swimLevelModel;
  final List<SwimSeason> swimSeasonOptions;
  final List<SwimLevelRadioButton> swimLevelOptions;
  final SwimSeasonModel swimSeason;
  final SwimSeasonModel swimLevelRB;
  final SwimSeason selectedSwimSeason;
  final SwimLevelRadioButton selectedSeimLevelRB;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  SwimLevelState copyWith({
    bool? isDirectLinks,
    SwimLevelModel? swimLevelModel,
    List<SwimSeason>? swimSeasonOptions,
    List<SwimLevelRadioButton>? swimLevelOptions,
    SwimSeasonModel? swimSeason,
    SwimSeasonModel? swimLevelRB,
    SwimSeason? selectedSwimSeason,
    SwimLevelRadioButton? selectedSeimLevelRB,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimLevelState(
      isDirectLinks: isDirectLinks ?? this.isDirectLinks,
      swimLevelModel: swimLevelModel ?? this.swimLevelModel,
      swimSeasonOptions: swimSeasonOptions ?? this.swimSeasonOptions,
      swimLevelOptions: swimLevelOptions ?? this.swimLevelOptions,
      swimSeason: swimSeason ?? this.swimSeason,
      swimLevelRB: swimLevelRB ?? this.swimLevelRB,
      selectedSwimSeason: selectedSwimSeason ?? this.selectedSwimSeason,
      selectedSeimLevelRB: selectedSeimLevelRB ?? this.selectedSeimLevelRB,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [
    isDirectLinks,
    swimLevelModel,
    swimSeasonOptions,
    swimLevelOptions,
    swimSeason,
    swimLevelRB,
    selectedSwimSeason,
    selectedSeimLevelRB,
    submissionStatus,
  ];
}
