part of 'swim_level_bloc.dart';

class SwimLevelState extends Equatable {
  const SwimLevelState({
    this.swimLevelModel = const SwimLevelModel.pure(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final SwimLevelModel swimLevelModel;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  SwimLevelState copyWith({
    SwimLevelModel? swimLevelModel,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimLevelState(
      swimLevelModel: swimLevelModel ?? this.swimLevelModel,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [swimLevelModel, submissionStatus];
}
