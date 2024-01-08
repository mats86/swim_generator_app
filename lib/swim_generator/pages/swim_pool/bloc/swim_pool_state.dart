part of 'swim_pool_bloc.dart';

class SwimPoolState extends Equatable {
  final List<SwimPool> swimPools;
  final FormzSubmissionStatus loadingStatus;
  final FormzSubmissionStatus toggleStatus;
  final SwimPoolModel swimPoolModel;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  const SwimPoolState({
    this.swimPools = const [],
    this.loadingStatus = FormzSubmissionStatus.initial,
    this.toggleStatus = FormzSubmissionStatus.initial,
    this.swimPoolModel = const SwimPoolModel.pure(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  SwimPoolState copyWith({
    List<SwimPool>? swimPools,
    FormzSubmissionStatus? loadingStatus,
    FormzSubmissionStatus? toggleStatus,
    SwimPoolModel? swimPoolModel,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimPoolState(
      swimPools: swimPools ?? this.swimPools,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus,
      swimPoolModel: swimPoolModel ?? this.swimPoolModel,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    swimPools,
    loadingStatus,
    toggleStatus,
    swimPoolModel,
    submissionStatus
  ];
}
