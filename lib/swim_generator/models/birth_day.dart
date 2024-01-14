import 'package:equatable/equatable.dart';

class BirthDay extends Equatable {
  final DateTime? birthDay;

  const BirthDay({
    this.birthDay,
  });

  const BirthDay.empty() : this(birthDay: null);

  BirthDay copyWith({
    DateTime? birthDay,
  }) {
    return BirthDay(
      birthDay: birthDay ?? this.birthDay,
    );
  }

  @override
  List<Object?> get props => [birthDay];
}
