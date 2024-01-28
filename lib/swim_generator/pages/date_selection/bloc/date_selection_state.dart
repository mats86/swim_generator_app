part of 'date_selection_bloc.dart';

class DateSelectionState extends Equatable {

  final List<FixDate> fixDates;
  final FixDateModel fixDateModel;
  final FixDate selectedFixDate;
  final FormzSubmissionStatus loadingFixDates;
  final bool hasFixedDesiredDate;
  final bool flexFixDate;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  const DateSelectionState({
    this.fixDates = const [],
    this.fixDateModel = const FixDateModel.pure(),
    this.selectedFixDate = const FixDate.empty(),
    this.loadingFixDates = FormzSubmissionStatus.initial,
    this.hasFixedDesiredDate = false,
    this.flexFixDate = false,
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  DateSelectionState copyWith({
    List<FixDate>? fixDates,
    FixDateModel? fixDateModel,
    FixDate? selectedFixDate,
    FormzSubmissionStatus? loadingFixDates,
    bool? hasFixedDesiredDate,
    bool? flexFixDate,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
}) {
    return DateSelectionState(
      fixDates: fixDates ?? this.fixDates,
      fixDateModel: fixDateModel ?? this.fixDateModel,
      selectedFixDate: selectedFixDate ?? this.selectedFixDate,
      loadingFixDates: loadingFixDates ?? this.loadingFixDates,
      hasFixedDesiredDate: hasFixedDesiredDate ?? this.hasFixedDesiredDate,
      flexFixDate: flexFixDate ?? this.flexFixDate,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object?> get props => [
    fixDates,
    fixDateModel,
    loadingFixDates,
    hasFixedDesiredDate,
    flexFixDate,
    submissionStatus
  ];
}