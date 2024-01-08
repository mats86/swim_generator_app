import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../bloc/birth_day_bloc.dart';
import 'birth_day_form.dart';



class BirthDayPage extends StatelessWidget {
  const BirthDayPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const BirthDayPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => BirthDayBloc(
          userRepository: context.read<UserRepository>(),
        ),
        child: const BirthDayForm(),
      ),
    );
  }
}