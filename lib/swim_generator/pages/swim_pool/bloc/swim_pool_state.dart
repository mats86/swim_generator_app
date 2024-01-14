part of 'swim_pool_bloc.dart';

class SwimPoolState extends Equatable {
  final List<SwimPool> swimPools;
  final List<FixDate> fixDates;
  final FormzSubmissionStatus loadingStatus;
  final FormzSubmissionStatus toggleStatus;
  final FormzSubmissionStatus loadingFixDates;
  final SwimPoolModel swimPoolModel;
  final bool hasFixedDate;
  final bool flexFixDate;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  const SwimPoolState({
    this.swimPools = const [],
    this.fixDates = const [],
    this.loadingStatus = FormzSubmissionStatus.initial,
    this.toggleStatus = FormzSubmissionStatus.initial,
    this.loadingFixDates = FormzSubmissionStatus.initial,
    this.swimPoolModel = const SwimPoolModel.pure(),
    this.hasFixedDate = false,
    this.flexFixDate = false,
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  SwimPoolState copyWith({
    List<SwimPool>? swimPools,
    List<FixDate>? fixDates,
    FormzSubmissionStatus? loadingStatus,
    FormzSubmissionStatus? toggleStatus,
    FormzSubmissionStatus? loadingFixDates,
    SwimPoolModel? swimPoolModel,
    bool? hasFixedDate,
    bool? flexFixDate,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return SwimPoolState(
      swimPools: swimPools ?? this.swimPools,
      fixDates: fixDates ?? this.fixDates,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus,
      loadingFixDates: loadingFixDates ?? this.loadingFixDates,
      swimPoolModel: swimPoolModel ?? this.swimPoolModel,
      hasFixedDate: hasFixedDate ?? this.hasFixedDate,
      flexFixDate: flexFixDate ?? this.flexFixDate,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    swimPools,
    fixDates,
    loadingStatus,
    toggleStatus,
    loadingFixDates,
    swimPoolModel,
    hasFixedDate,
    flexFixDate,
    submissionStatus
  ];
}
