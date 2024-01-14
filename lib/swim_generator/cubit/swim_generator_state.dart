part of 'swim_generator_cubit.dart';

class SwimGeneratorState extends Equatable {
  const SwimGeneratorState({
    this.activeStepperIndex = 0,
    required this.shouldUseFutureBuilderList,
    this.swimLevel = const SwimLevel.empty(),
    this.birthDay = const BirthDay.empty(),
    this.swimCourseInfo = const SwimCourseInfo.empty(),
    this.swimPools = const [],
    this.kindPersonalInfo = const KindPersonalInfo(),
  });

  final int activeStepperIndex;
  final List<bool> shouldUseFutureBuilderList;
  final SwimLevel swimLevel;
  final BirthDay birthDay;
  final SwimCourseInfo swimCourseInfo;
  final List<SwimPoolInfo> swimPools;
  final KindPersonalInfo kindPersonalInfo;

  SwimGeneratorState copyWith({
    int? activeStepperIndex,
    List<bool>? shouldUseFutureBuilderList,
    SwimLevel? swimLevel,
    BirthDay? birthDay,
    SwimCourseInfo? swimCourseInfo,
    List<SwimPoolInfo>? swimPools,
    KindPersonalInfo? kindPersonalInfo,
  }) {
    return SwimGeneratorState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
      shouldUseFutureBuilderList:
          shouldUseFutureBuilderList ?? this.shouldUseFutureBuilderList,
      swimLevel: swimLevel ?? this.swimLevel,
      birthDay: birthDay ?? this.birthDay,
      swimCourseInfo: swimCourseInfo ?? this.swimCourseInfo,
      swimPools: swimPools ?? this.swimPools,
      kindPersonalInfo: kindPersonalInfo ?? this.kindPersonalInfo,
    );
  }

  @override
  List<Object> get props => [
        activeStepperIndex,
        shouldUseFutureBuilderList,
        swimLevel,
        birthDay,
        swimCourseInfo,
        swimPools,
        kindPersonalInfo,
      ];
}
