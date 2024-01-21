part of 'kind_personal_info_bloc.dart';

class KindPersonalInfoState extends Equatable {
  const KindPersonalInfoState({
    this.firstName = const FirstNameModel.pure(),
    this.lastName = const LastNameModel.pure(),
    this.isPhysicalDelay = const CheckboxModel.pure(),
    this.isMentalDelay = const CheckboxModel.pure(),
    this.isNoLimit = const CheckboxModel.pure(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final FirstNameModel firstName;
  final LastNameModel lastName;
  final CheckboxModel isPhysicalDelay;
  final CheckboxModel isMentalDelay;
  final CheckboxModel isNoLimit;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  KindPersonalInfoState copyWith({
    FirstNameModel? firstName,
    LastNameModel? lastName,
    CheckboxModel? isPhysicalDelay,
    CheckboxModel? isMentalDelay,
    CheckboxModel? isNoLimit,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return KindPersonalInfoState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isPhysicalDelay: isPhysicalDelay ?? this.isPhysicalDelay,
      isMentalDelay: isMentalDelay ?? this.isMentalDelay,
      isNoLimit: isNoLimit ?? this.isNoLimit,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [
        firstName,
        lastName,
        isPhysicalDelay,
        isMentalDelay,
        isNoLimit,
        submissionStatus,
      ];
}
