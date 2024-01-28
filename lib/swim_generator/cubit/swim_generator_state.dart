part of 'swim_generator_cubit.dart';

class SwimGeneratorState extends Equatable {
  const SwimGeneratorState({
    this.activeStepperIndex = 0,
    this.swimLevel = const SwimLevel.empty(),
    this.birthDay = const BirthDay.empty(),
    this.swimCourseInfo = const SwimCourseInfo.empty(),
    this.swimPools = const [],
    this.dateSelection = const DateSelection.empty(),
    this.kindPersonalInfo = const KindPersonalInfo.empty(),
    this.personalInfo = const PersonalInfo.empty(),
    this.configApp = const ConfigApp.empty(),
  });

  final int activeStepperIndex;
  final SwimLevel swimLevel;
  final BirthDay birthDay;
  final SwimCourseInfo swimCourseInfo;
  final List<SwimPoolInfo> swimPools;
  final DateSelection dateSelection;
  final KindPersonalInfo kindPersonalInfo;
  final PersonalInfo personalInfo;
  final ConfigApp configApp;

  SwimGeneratorState copyWith({
    int? activeStepperIndex,
    List<bool>? shouldUseFutureBuilderList,
    SwimLevel? swimLevel,
    BirthDay? birthDay,
    SwimCourseInfo? swimCourseInfo,
    List<SwimPoolInfo>? swimPools,
    DateSelection? dateSelection,
    KindPersonalInfo? kindPersonalInfo,
    PersonalInfo? personalInfo,
    bool? isEmailExists,
    ConfigApp? configApp,
  }) {
    return SwimGeneratorState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
      swimLevel: swimLevel ?? this.swimLevel,
      birthDay: birthDay ?? this.birthDay,
      swimCourseInfo: swimCourseInfo ?? this.swimCourseInfo,
      swimPools: swimPools ?? this.swimPools,
      dateSelection: dateSelection ?? this.dateSelection,
      kindPersonalInfo: kindPersonalInfo ?? this.kindPersonalInfo,
      personalInfo: personalInfo ?? this.personalInfo,
      configApp: configApp ?? this.configApp,
    );
  }

  @override
  List<Object> get props => [
        activeStepperIndex,
        swimLevel,
        birthDay,
        swimCourseInfo,
        swimPools,
        dateSelection,
        kindPersonalInfo,
        personalInfo,
        configApp,
      ];
}
