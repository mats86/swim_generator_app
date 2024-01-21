part of 'swim_pool_bloc.dart';

class SwimPoolState extends Equatable {
  final bool isBooking;
  final List<SwimPool> swimPools;
  final List<FixDate> fixDates;
  final List<FixDate> fixDatesVisible;
  final FixDateModel fixDateModel;
  final FixDate selectedFixDate;
  final FormzSubmissionStatus loadingStatus;
  final FormzSubmissionStatus toggleStatus;
  final FormzSubmissionStatus loadingFixDates;
  final SwimPoolModel swimPoolModel;
  final bool hasFixedDate;
  final bool flexFixDate;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  const SwimPoolState({
    this.isBooking = false,
    this.swimPools = const [],
    this.fixDates = const [],
    this.fixDatesVisible = const [],
    this.fixDateModel = const FixDateModel.pure(),
    this.selectedFixDate = const FixDate.empty(),
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
    bool? isBooking,
    List<SwimPool>? swimPools,
    List<FixDate>? fixDates,
    List<FixDate>? fixDatesVisible,
    FixDateModel? fixDateModel,
    FixDate? selectedFixDate,
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
      isBooking: isBooking ?? this.isBooking,
      swimPools: swimPools ?? this.swimPools,
      fixDates: fixDates ?? this.fixDates,
      fixDatesVisible: fixDatesVisible ?? this.fixDatesVisible,
      fixDateModel: fixDateModel ?? this.fixDateModel,
      selectedFixDate: selectedFixDate ?? this.selectedFixDate,
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
        isBooking,
        swimPools,
        fixDates,
        fixDatesVisible,
        fixDateModel,
        loadingStatus,
        toggleStatus,
        loadingFixDates,
        swimPoolModel,
        hasFixedDate,
        flexFixDate,
        submissionStatus
      ];
}
