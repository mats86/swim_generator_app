import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/view/swim_generator_stepper.dart';
import 'package:user_repository/user_repository.dart';

import '../cubit/swim_generator_cubit.dart';

class SwimGeneratorPage extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final String title;

  const SwimGeneratorPage(
      {super.key, required this.graphQLClient, required this.title});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>(
      create: (_) => UserRepository(),
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: const Color(0xFF009EE1),
        //   title: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       const Text('Schwimmkurs Konfigurator'), // Erste Zeile
        //       Text(title), // Zweite Zeile
        //     ],
        //   ),
        //   centerTitle: true,
        // ),
        body: BlocProvider<SwimGeneratorCubit>(
          create: (_) => SwimGeneratorCubit(7),
          child: SwimGeneratorStepper(graphQLClient: graphQLClient),
        ),
      ),
    );
  }
}
