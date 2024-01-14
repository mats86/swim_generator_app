import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/view/swim_generator_stepper.dart';

import '../cubit/swim_generator_cubit.dart';

class SwimGeneratorPage extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final String title;

  const SwimGeneratorPage(
      {super.key, required this.graphQLClient, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwimGeneratorCubit>(
      create: (_) => SwimGeneratorCubit(7),
      child: SwimGeneratorStepper(graphQLClient: graphQLClient),
    );
  }
}
