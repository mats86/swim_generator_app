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
        List<int> generateStepNumbers(int length, bool isAdultCourse) {
          List<int> steps = List.generate(length, (index) => index + 1);
          if (isAdultCourse) {
            steps.removeLast(); // Entferne den Kinder Step aus der Liste
          }
          return steps;
        }
        return SwimGeneratorFormShell(
          child: Column(
            children: [
              NumberStepper(
                enableNextPreviousButtons: false,
                enableStepTapping: false,
                activeStepColor: Colors.lightBlueAccent,
                numbers: generateStepNumbers(order.length, state.isAdultCourse),
                activeStep: state.activeStepperIndex,
                onStepReached: (index) {
                  context.read<SwimGeneratorCubit>().stepTapped(index);
                },
              ),
              header(
                state.activeStepperIndex,
                context.read<SwimGeneratorCubit>().state.configApp.isBooking,
                state.isAdultCourse,
              ),
              body(
                state.activeStepperIndex,
                swimCourseID,
                isDirectLinks,
                state.isAdultCourse,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Returns the header wrapping the header text.
  Widget header(
    int activeStepperIndex,
    bool isBooking,
    bool isAdultCourse,
  ) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          headerText(
            activeStepperIndex,
            isDirectLinks,
            isBooking,
            isAdultCourse,
          ),
          style: const TextStyle(
            // color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText(
    int activeStepperIndex,
    bool isDirectLinks,
    bool isBooking,
    bool isAdultCourse,
  ) {
    int pageIndex = order[activeStepperIndex];

    switch (pageIndex) {
      case 0:
        if (isDirectLinks) {
          return 'TERMIN-WAHL';
        } else {
          return 'Schwimmniveau';
        }

      case 1:
        return 'Geburtsdatum';

      case 2:
        return 'Schwimmkurs';

      case 3:
        return 'Schwimmbad';

      case 4:
        if (isBooking) {
          return 'TERMINWAHL';
        } else {
          return 'Hinweis Verein';
        }

      case 5:
        return 'DATEN zum SCHWIMSCHÜLER:IN';

      case 6:
        if (isAdultCourse) {
          return 'Deine erfassten Daten';
        } else {
          return 'Erziehungsberechtigten Information';
        }

      case 7:
        return 'Deine erfassten Daten';

      default:
        return '';
    }
  }

  /// Returns the body.
  Widget body(
    int activeStepperIndex,
    int swimCourseID,
    bool isDirectLinks,
    bool isAdultCourse,
  ) {
    int pageIndex = order[activeStepperIndex];

    switch (pageIndex) {
      case 0:
        return SwimLevelPage(
          isDirectLinks: isDirectLinks,
        );

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
        if (isAdultCourse) {
          return ParentPersonalInfoPage(
            graphQLClient: graphQLClient,
          );
        } else {
          return const KindPersonalInfoPage();
        }

      case 6:
        if (isAdultCourse) {
          return ResultPage(graphQLClient: graphQLClient);
        } else {
          return ParentPersonalInfoPage(
            graphQLClient: graphQLClient,
          );
        }

      case 7:
        return ResultPage(graphQLClient: graphQLClient);

      default:
        return Container();
    }
  }
}
