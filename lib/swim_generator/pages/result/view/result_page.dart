import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/pages/result/bloc/result_bloc.dart';
import 'package:swim_generator_app/swim_generator/pages/result/view/result_form.dart';
import 'package:user_repository/user_repository.dart';

import '../../swim_course/bloc/swim_course_bloc.dart';

class ResultPage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const ResultPage({super.key, required this.graphQLClient});

  Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ResultPage(
              graphQLClient: graphQLClient,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12.0),
        child: BlocProvider(
          create: (context) => ResultBloc(
            ResultRepository(graphQLClient: graphQLClient),
            context.read<UserRepository>(),
          ),
          child: const ResultForm(),
        ));
  }
}
