import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/birth_day_bloc.dart';
import 'birth_day_form.dart';



class BirthDayPage extends StatelessWidget {
  const BirthDayPage({super.key, required this.shouldUseFutureBuilder});
  final bool shouldUseFutureBuilder;

  Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => BirthDayPage(shouldUseFutureBuilder: shouldUseFutureBuilder,),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => BirthDayBloc(
        ),
        child: BirthDayForm(shouldUseFutureBuilder: shouldUseFutureBuilder,),
      ),
    );
  }
}