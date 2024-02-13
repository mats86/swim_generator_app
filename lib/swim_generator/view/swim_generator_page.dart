import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/view/swim_generator_stepper.dart';

import '../cubit/swim_generator_cubit.dart';

class SwimGeneratorPage extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final String title;
  final List<int> order;
  final int swimCourseID;
  final bool isDirectLinks;

  const SwimGeneratorPage({
    super.key,
    required this.graphQLClient,
    required this.title,
    this.order = const [0, 1, 2, 3, 4, 5, 6],
    this.swimCourseID = 0,
    this.isDirectLinks = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwimGeneratorCubit>(
      create: (_) => SwimGeneratorCubit(order.length),
      child: SwimGeneratorStepper(
        graphQLClient: graphQLClient,
        order: order,
        swimCourseID: swimCourseID,
        isDirectLinks: isDirectLinks,
      ),
    );
  }
}
