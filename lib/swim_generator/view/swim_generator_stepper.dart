import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:swim_generator_app/swim_generator/pages/date_selection/view/date_selection_page.dart';
import 'package:swim_generator_app/swim_generator/view/swim_generator_form_shell.dart';

import '../cubit/swim_generator_cubit.dart';
import '../pages/pages.dart';

class SwimGeneratorStepper extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final List<int> order;
  final int swimCourseID;
  final bool isDirectLinks;

  const SwimGeneratorStepper({
    super.key,
    required this.graphQLClient,
    required this.order,
    required this.swimCourseID,
    required this.isDirectLinks,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimGeneratorCubit, SwimGeneratorState>(
      builder: (context, state) {
        return SwimGeneratorFormShell(
          child: Column(
            children: [
              NumberStepper(
                enableNextPreviousButtons: false,
                enableStepTapping: false,
                activeStepColor: Colors.lightBlueAccent,
                numbers: List.generate(order.length, (index) => index + 1),
                activeStep: state.activeStepperIndex,
                onStepReached: (index) {
                  context.read<SwimGeneratorCubit>().stepTapped(index);
                },
              ),
              header(state.activeStepperIndex),
              body(
                state.activeStepperIndex,
                swimCourseID,
                isDirectLinks,
              ),
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
          headerText(activeStepperIndex, isDirectLinks),
          style: const TextStyle(
            // color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText(int activeStepperIndex, bool isDirectLinks) {
    int pageIndex = order[activeStepperIndex];

    switch (pageIndex) {
      case 0:
        if (isDirectLinks) {
          return 'TERMIN-WAHL';
        } else {
          return 'Schwimmniveau';
        }

      case 1:
        return 'GeburstDatum';

      case 2:
        return 'Schwimm Kurs';

      case 3:
        return 'Schwimmbad';

      case 4:
        return 'TIME AUSWAHL';

      case 5:
        return 'Kind Information';

      case 6:
        return 'Erziehungsberechtigten Information';

      case 7:
        return 'Deine erfassten Daten';

      default:
        return '';
    }
  }

  /// Returns the body.
  Widget body(int activeStepperIndex, int swimCourseID, bool isDirectLinks) {
    int pageIndex = order[activeStepperIndex];

    switch (pageIndex) {
      case 0:
        return SwimLevelPage(isDirectLinks: isDirectLinks);

      case 1:
        return BirthDayPage(
          swimCourseID: swimCourseID,
          graphQLClient: graphQLClient,
        );

      case 2:
        return SwimCoursePage(graphQLClient: graphQLClient);

      case 3:
        return SwimPoolPage(graphQLClient: graphQLClient);

      case 4:
        return DateSelectionPage(graphQLClient: graphQLClient);

      case 5:
        return const KindPersonalInfoPage();

      case 6:
        return ParentPersonalInfoPage(
          graphQLClient: graphQLClient,
        );

      case 7:
        return ResultPage(graphQLClient: graphQLClient);

      default:
        return Container();
    }
  }
}
