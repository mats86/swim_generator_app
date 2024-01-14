import 'package:equatable/equatable.dart';

class SwimLevel extends Equatable {
  final SwimLevelEnum? swimLevel;

  const SwimLevel({
    this.swimLevel,
  });

  const SwimLevel.empty() : this(swimLevel: SwimLevelEnum.EINSTIEGERKURS);


  SwimLevel copyWith({
    SwimLevelEnum? swimLevel,
  }) {
    return SwimLevel(
      swimLevel: swimLevel ?? this.swimLevel,
    );
  }

  @override
  List<Object?> get props => [swimLevel];
}

enum SwimLevelEnum { EINSTIEGERKURS, AUFSTIEGERKURS }

