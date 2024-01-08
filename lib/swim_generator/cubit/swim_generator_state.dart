part of 'swim_generator_cubit.dart';

class SwimGeneratorState extends Equatable {
  const SwimGeneratorState({
    this.activeStepperIndex = 0,
  });

  final int activeStepperIndex;

  SwimGeneratorState copyWith({int? activeStepperIndex}) {
    return SwimGeneratorState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
    );
  }

  @override
  List<Object> get props => [activeStepperIndex];
}