import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:swim_generator_app/swim_generator/view/swim_generator_form_shell.dart';

import '../cubit/swim_generator_cubit.dart';
import '../pages/pages.dart';

class SwimGeneratorStepper extends StatelessWidget {
  final GraphQLClient graphQLClient;
  const SwimGeneratorStepper({super.key, required this.graphQLClient});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimGeneratorCubit, SwimGeneratorState>(
      builder: (context, state) {
        return SwimGeneratorFormShell(
          child: Column(
            children: [
              NumberStepper(
                enableNextPreviousButtons: false,
                enableStepTapping: true,
                activeStepColor: Colors.lightBlueAccent,
                numbers: const [
                  1,
                  2,
                  3,
                  4,
                  5,
                  6,
                  7,
                ],
                activeStep: state.activeStepperIndex,
                onStepReached: (index) {
                  context.read<SwimGeneratorCubit>().stepTapped(index);
                },
              ),
              header(state.activeStepperIndex),
              body(state.activeStepperIndex,
                  state.shouldUseFutureBuilderList[state.activeStepperIndex]),
            ],
          ),
        );
      },
    );
  }

  /// Returns the header wrapping the header text.
  Widget header(int activeStepperIndex) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          headerText(activeStepperIndex),
          style: const TextStyle(
            // color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText(int activeStepperIndex) {
    switch (activeStepperIndex) {
      case 0:
        return 'Schwimmniveau';

      case 1:
        return 'GeburstDatum';

      case 2:
        return 'Schwimm Kurs';

      case 3:
        return 'Schwimmbad';

      case 4:
        return 'Kind Information';

      case 5:
        return 'Erziehungsberechtigten Information';

      case 6:
        return 'Zusammenfassen';

      default:
        return '';
    }
  }

  /// Returns the body.
  Widget body(int activeStepperIndex, bool shouldUseFutureBuilder) {
    switch (activeStepperIndex) {
      case 0:
        return SwimLevelPage(shouldUseFutureBuilder: shouldUseFutureBuilder);

      case 1:
        return BirthDayPage(shouldUseFutureBuilder: shouldUseFutureBuilder);

      case 2:
        return SwimCoursePage(graphQLClient: graphQLClient);

      case 3:
        return SwimPoolPage(graphQLClient: graphQLClient);

      case 4:
        return const KindPersonalInfoPage();

      case 5:
        return const ParentPersonalInfoPage();

      case 6:
        return ResultPage(graphQLClient: graphQLClient);

      default:
        return Container();
    }
  }
}
