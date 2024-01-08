part of 'kind_personal_info_bloc.dart';

class KindPersonalInfoState extends Equatable {
  const KindPersonalInfoState({
    this.firstName = const FirstNameModel.pure(),
    this.lastName = const LastNameModel.pure(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final FirstNameModel firstName;
  final LastNameModel lastName;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  KindPersonalInfoState copyWith({
    FirstNameModel? firstName,
    LastNameModel? lastName,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return KindPersonalInfoState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, submissionStatus];
}