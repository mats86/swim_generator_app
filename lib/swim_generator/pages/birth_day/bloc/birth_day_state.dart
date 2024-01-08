part of 'birth_day_bloc.dart';

class BirthDayState extends Equatable {
  const BirthDayState({
    this.birthDay = const BirthDayModel.pure(),
    this.isValid = false,
    this.submissionStatus = FormzSubmissionStatus.initial,
  });

  final BirthDayModel birthDay;
  final bool isValid;
  final FormzSubmissionStatus submissionStatus;

  BirthDayState copyWith({
    BirthDayModel? birthDay,
    bool? isValid,
    FormzSubmissionStatus? submissionStatus,
  }) {
    return BirthDayState(
      birthDay: birthDay ?? this.birthDay,
      isValid: isValid ?? this.isValid,
      submissionStatus: submissionStatus ?? this.submissionStatus,
    );
  }

  @override
  List<Object> get props => [birthDay, submissionStatus];
}