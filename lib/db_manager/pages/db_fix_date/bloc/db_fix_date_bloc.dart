import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../../graphql/graphql_queries.dart';
import '../../../../swim_generator/pages/date_selection/model/model.dart';

part 'db_fix_date_event.dart';
part 'db_fix_date_repository.dart';
part 'db_fix_date_state.dart';

class DbFixDateBloc extends Bloc<DbFixDateEvent, DbFixDateState> {
  final DbFixDateRepository service;

  DbFixDateBloc(this.service) : super(const DbFixDateState()) {
    on<LoadFixDateOptions>(_onLoadFixDateOptions);
  }

  void _onLoadFixDateOptions(
      LoadFixDateOptions event, Emitter<DbFixDateState> emit) async {
    emit(
        state.copyWith(loadingFixDateStatus: FormzSubmissionStatus.inProgress));
    try {
      final fixDates = await service.getFixDatesWithDetails();
      emit(state.copyWith(
          fixDateOptions: fixDates,
          loadingFixDateStatus: FormzSubmissionStatus.success));
    } catch (e) {
      // Hier können Sie spezifische Fehler loggen
      if (kDebugMode) {
        print('Fehler beim Laden der Schwimmkurse: $e');
      }
      emit(state.copyWith(loadingFixDateStatus: FormzSubmissionStatus.failure));
    }
  }
}
