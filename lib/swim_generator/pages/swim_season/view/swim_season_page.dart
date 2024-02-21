

import 'package:flutter/material.dart';

class SwimSeasonPage extends StatelessWidget {

  const SwimSeasonPage({
    super.key,
  });

  route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SwimSeasonPage(
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => SwimSeasonBloc(),
        child: SwimSeasonForm(
        ),
      ),
    );
  }
}
