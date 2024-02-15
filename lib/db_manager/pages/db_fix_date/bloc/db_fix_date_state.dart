part of 'db_fix_date_bloc.dart';

class DbFixDateState extends Equatable {
  const DbFixDateState({
    this.fixDateOptions = const [],
    this.loadingFixDateStatus = FormzSubmissionStatus.initial,
  });

  final List<FixDateDetail> fixDateOptions;
  final FormzSubmissionStatus loadingFixDateStatus;

  DbFixDateState copyWith({
    List<FixDateDetail>? fixDateOptions,
    FormzSubmissionStatus? loadingFixDateStatus,
  }) {
    return DbFixDateState(
      fixDateOptions: fixDateOptions ?? this.fixDateOptions,
      loadingFixDateStatus: loadingFixDateStatus ?? this.loadingFixDateStatus,
    );
  }

  @override
  List<Object?> get props => [fixDateOptions, loadingFixDateStatus];
}
