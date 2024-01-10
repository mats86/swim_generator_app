part of 'swim_generator_cubit.dart';

class SwimGeneratorState extends Equatable {
  const SwimGeneratorState({
    this.activeStepperIndex = 0,
    required this.shouldUseFutureBuilderList,
  });

  final int activeStepperIndex;
  final List<bool> shouldUseFutureBuilderList;

  SwimGeneratorState copyWith({
    int? activeStepperIndex,
    List<bool>? shouldUseFutureBuilderList,
  }) {
    return SwimGeneratorState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
      shouldUseFutureBuilderList:
      shouldUseFutureBuilderList ?? this.shouldUseFutureBuilderList,
    );
  }

  @override
  List<Object> get props => [activeStepperIndex, shouldUseFutureBuilderList];
}
