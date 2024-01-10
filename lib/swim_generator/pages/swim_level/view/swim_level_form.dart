import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_level/bloc/swim_level_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../models/swim_level_model.dart';

class SwimLevelForm extends StatefulWidget {
  const SwimLevelForm({super.key, required this.shouldUseFutureBuilder});
  final bool shouldUseFutureBuilder;

  @override
  State<SwimLevelForm> createState() => _SwimLevelForm();
}

class _SwimLevelForm extends State<SwimLevelForm> {
  late Future<User?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = context.read<SwimLevelBloc>().userRepository.getUser();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shouldUseFutureBuilder) {
      return FutureBuilder(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitWaveSpinner(
              color: Colors.lightBlueAccent,
              size: 50.0,
            );
          }
          if (snapshot.hasData && snapshot.data!.swimLevel.swimLevel != null) {
            SwimLevelEnum swimLevel = snapshot.data!.swimLevel.swimLevel!;
            context.read<SwimLevelBloc>().add(SwimLevelChanged(
                SwimLevelModel.dirty(SwimLevelEnum.values[swimLevel.index])));
          }
          return buildBlocBuilder(snapshot.data!.swimLevel.swimLevel!);
        },
      );
    }
    return buildBlocBuilder();
  }

  Widget buildBlocBuilder(
      [SwimLevelEnum swimLevelEnum = SwimLevelEnum.EINSTIEGERKURS]) {
    return BlocListener<SwimLevelBloc, SwimLevelState>(
      listener: (context, state) {
        if (state.submissionStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            height: 16.0,
          ),
          const Text("Wähle bitte Dein Schwimmniveau aus?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 24.0,
          ),
          _SwimLevelSelected(defaultSwimLevel: swimLevelEnum),
          const SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _CancelButton()),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(child: _SubmitButton())
            ],
          )
        ],
      ),
    );
  }
}

class _SwimLevelSelected extends StatelessWidget {
  final SwimLevelEnum defaultSwimLevel;

  const _SwimLevelSelected({required this.defaultSwimLevel});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimLevelBloc, SwimLevelState>(
      buildWhen: (previous, current) =>
      previous.swimLevelModel != current.swimLevelModel,
      builder: (context, state) {
        List<bool> isSelected = [
          state.swimLevelModel.value == SwimLevelEnum.EINSTIEGERKURS,
          state.swimLevelModel.value == SwimLevelEnum.AUFSTIEGERKURS,
        ];

        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildToggleButton(
                  Icons.waves, "EINSTIEGERKURS", isSelected[0], 0, context),
              const SizedBox(width: 8.0),
              _buildToggleButton(
                  Icons.pool, "AUFSTIEGERKURS", isSelected[1], 1, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleButton(IconData icon, String text, bool isSelected,
      int index, BuildContext context) {
    return TextButton(
      onPressed: () => context.read<SwimLevelBloc>().add(
          SwimLevelChanged(SwimLevelModel.dirty(SwimLevelEnum.values[index]))),
      style: TextButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        foregroundColor: isSelected ? Colors.blue : Colors.grey,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: isSelected ? Colors.black : Colors.transparent,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon,
              size: 60.0, color: isSelected ? Colors.black : Colors.white),
          const SizedBox(height: 8.0),
          Text(text,
              style:
              TextStyle(color: isSelected ? Colors.black : Colors.white)),
        ],
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwimLevelBloc, SwimLevelState>(
      listenWhen: (previous, current) =>
      previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
        }
      },
      buildWhen: (previous, current) =>
      previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        final isValid =
        context.select((SwimLevelBloc bloc) => bloc.state.isValid);
        return state.submissionStatus.isInProgress
            ? const SpinKitWaveSpinner(
          color: Colors.lightBlueAccent,
          size: 50.0,
        )
            : ElevatedButton(
          key: const Key(
              'kindPersonalInfoForm_submitButton_elevatedButton'),
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: Colors.lightBlueAccent),
          onPressed: isValid
              ? () => context.read<SwimLevelBloc>().add(FormSubmitted())
              : null,
          child: const Text(
            'Weiter',
            style: TextStyle(
              color: Colors.white, // Ändert die Textfarbe
              fontSize: 16, // Ändert die Schriftgröße
              fontWeight: FontWeight.bold, // Ändert das Schriftgewicht
              // Hier können Sie weitere Textstileinstellungen vornehmen
            ),
          ),
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimLevelBloc, SwimLevelState>(
        buildWhen: (previous, current) =>
        previous.submissionStatus != current.submissionStatus,
        builder: (context, state) {
          return state.submissionStatus.isInProgress
              ? const SizedBox.shrink()
              : TextButton(
            key: const Key(
                'kindPersonalInfoForm_cancelButton_elevatedButton'),
            onPressed: () =>
                context.read<SwimGeneratorCubit>().stepCancelled(),
            child: const Text(
              'Abrechen',
            ),
          );
        });
  }
}
