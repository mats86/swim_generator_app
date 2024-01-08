part of 'swim_generator_cubit.dart';

class SwimGeneratorState extends Equatable {
  const SwimGeneratorState({
    this.activeStepperIndex = 0,
    this.shouldUseFutureBuilder = false,
  });

  final int activeStepperIndex;
  final bool shouldUseFutureBuilder;

  SwimGeneratorState copyWith({
    int? activeStepperIndex,
    bool? shouldUseFutureBuilder,
  }) {
    return SwimGeneratorState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
      shouldUseFutureBuilder:
      shouldUseFutureBuilder ?? this.shouldUseFutureBuilder,
    );
  }

  @override
  List<Object> get props => [activeStepperIndex];
}
