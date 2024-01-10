import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../bloc/swim_pool_bloc.dart';

class SwimPoolForm extends StatefulWidget {
  const SwimPoolForm({super.key});

  @override
  State<SwimPoolForm> createState() => _SwimPoolForm();
}

class _SwimPoolForm extends State<SwimPoolForm> {
  @override
  void initState() {
    super.initState();
    context.read<SwimPoolBloc>().add(LoadSwimPools());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwimPoolBloc, SwimPoolState>(
      listener: (context, state) {
        if (state.toggleStatus.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text("Welche Bäder kommen für dich in Frage? *"),
          ),
          const Divider(
            thickness: 2,
          ),
          _SwimPoolCheckBox(),
          const SizedBox(
            height: 16.0,
          ),
          const Divider(
            thickness: 2,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Für die Terminierung kommen wir bis zum 31. '
                'Dezember auf dich zu.'),
          ),
          const SizedBox(
            height: 32,
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

class _SwimPoolCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimPoolBloc, SwimPoolState>(
        buildWhen: (previous, current) =>
        previous.swimPools != current.swimPools,
        builder: (context, state) {
          return !state.loadingStatus.isSuccess
              ? const SpinKitWaveSpinner(
            color: Colors.lightBlueAccent,
            size: 50.0,
          )
              : ListView.builder(
              key: const Key('SwimPoolForm_swimPoolList_listView'),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: state.swimPools.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: CheckboxListTile(
                          activeColor: Colors.lightBlueAccent,
                          key: Key(state.swimPools[index].swimPoolName),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(state.swimPools[index].swimPoolName),
                          onChanged: (val) {
                            BlocProvider.of<SwimPoolBloc>(context)
                                .add(SwimPoolOptionToggled(index, val!));
                          },
                          value: state.swimPools[index].isSelected),
                    ),
                    const SizedBox(
                      width: 8.0,
                    )
                  ],
                );
              });
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwimPoolBloc, SwimPoolState>(
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
        context.select((SwimPoolBloc bloc) => bloc.state.isValid);
        return state.submissionStatus.isInProgress
            ? const SpinKitWaveSpinner(
          color: Colors.lightBlueAccent,
          size: 50.0,
        )
            : ElevatedButton(
          key: const Key('swimCourseForm_submitButton_elevatedButton'),
          style: ElevatedButton.styleFrom(
              elevation: 0, backgroundColor: Colors.lightBlueAccent),
          onPressed: isValid
              ? () => context.read<SwimPoolBloc>().add(FormSubmitted())
              : null,
          child: const Text(
            'Weiter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
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
    return BlocBuilder<SwimPoolBloc, SwimPoolState>(
        buildWhen: (previous, current) =>
        previous.toggleStatus != current.toggleStatus,
        builder: (context, state) {
          return state.toggleStatus.isInProgress
              ? const SizedBox.shrink()
              : TextButton(
            key: const Key('swimCourseForm_cancelButton_elevatedButton'),
            onPressed: () =>
                context.read<SwimGeneratorCubit>().stepCancelled(),
            child: const Text('Zurück'),
          );
        });
  }
}
