import 'package:equatable/equatable.dart';

import '../pages/swim_level/models/models.dart';

class SwimLevel extends Equatable {
  final SwimLevelEnum? swimLevel;
  final SwimSeason? swimSeason;

  const SwimLevel({
    this.swimLevel,
    this.swimSeason,
  });

  const SwimLevel.empty()
      : swimLevel = SwimLevelEnum.UNDEFINED,
        swimSeason = const SwimSeason.empty();

  SwimLevel copyWith({SwimLevelEnum? swimLevel, SwimSeason? swimSeason}) {
    return SwimLevel(
      swimLevel: swimLevel ?? this.swimLevel,
      swimSeason: swimSeason ?? this.swimSeason,
    );
  }

  bool get isEmpty {
    return swimLevel == SwimLevelEnum.UNDEFINED;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  @override
  List<Object?> get props => [swimLevel, swimSeason];
}

enum SwimLevelEnum { EINSTIEGERKURS, AUFSTIEGERKURS, UNDEFINED }
