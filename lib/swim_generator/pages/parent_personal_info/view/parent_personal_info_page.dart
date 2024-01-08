import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../bloc/parent_personal_info_bloc.dart';
import 'parent_personal_info_form.dart';

class ParentPersonalInfoPage extends StatelessWidget {
  const ParentPersonalInfoPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ParentPersonalInfoPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => ParentPersonalInfoBloc(
          ParentPersonalInfoRepository(),
          context.read<UserRepository>(),
        ),
        child: const ParentPersonalInfoForm(),
      ),
    );
  }
}
