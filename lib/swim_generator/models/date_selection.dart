import 'package:equatable/equatable.dart';
import 'package:swim_generator_app/swim_generator/pages/date_selection/model/fix_date.dart';

class DateSelection extends Equatable {
  final FixDate fixDate;
  final bool flexFixDate;

  const DateSelection({required this.fixDate, required this.flexFixDate});

  const DateSelection.empty()
      : this(fixDate: const FixDate.empty(), flexFixDate: false,);

  DateSelection copyWith({
    FixDate? fixDate,
    bool? flexFixDate,
  }) {
    return DateSelection(
      fixDate: fixDate ?? this.fixDate,
        flexFixDate: flexFixDate ?? this.flexFixDate,
    );
  }

  bool get isEmpty {
    return fixDate.isEmpty;
  }

  bool get isNotEmpty {
    return fixDate.isNotEmpty;
  }

  @override
  List<Object?> get props => [
    fixDate,
    flexFixDate,
  ];
}