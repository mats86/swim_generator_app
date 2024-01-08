import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../bloc/swim_course_bloc.dart';

class SwimCourseForm extends StatefulWidget {
  const SwimCourseForm({super.key});

  @override
  State<SwimCourseForm> createState() => _SwimCourseForm();
}

class _SwimCourseForm extends State<SwimCourseForm> {
  @override
  void initState() {
    super.initState();
    context.read<SwimCourseBloc>().add(LoadSwimSeasonOptions());
    // context.read<SwimCourseBloc>().add(LoadSwimCourseOptions());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwimCourseBloc, SwimCourseState>(
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
        children: [
          _SwimCourseSeason(),
          const SizedBox(
            height: 32,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Dem Alter entsprechende Kurse",
            ),
          ),
          _SwimCourseRadioButton(),
          const Divider(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "¹ Eine Kursübersicht über all unsere von uns angebotenen Kurse.",
            ),
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

class _SwimCourseSeason extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimCourseBloc, SwimCourseState>(
      builder: (context, state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            labelText: 'Für welche Sommer-Saison möchtest du den Kurs buchen?',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          child: DropdownButtonHideUnderline(
            child: !state.loadingSeasonStatus.isSuccess
                ? const SpinKitWaveSpinner(
                    color: Colors.lightBlueAccent,
                    size: 50.0,
                  )
                : DropdownButton<String>(
                    isExpanded: true,
                    value: state.swimSeason
                        .value, // Hier sollte der ausgewählte Wert sein
                    items: state.swimSeasons.map((String season) {
                      return DropdownMenuItem<String>(
                        value: season,
                        child: Text(season),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Dies wird aufgerufen, wenn der Benutzer ein Element auswählt.
                      BlocProvider.of<SwimCourseBloc>(context)
                          .add(SwimSeasonChanged(value!));
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _SwimCourseRadioButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: context.read<UserRepository>().getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final User user = snapshot.data!;
          context.read<SwimCourseBloc>().add(const LoadSwimCourseOptions());
          return BlocBuilder<SwimCourseBloc, SwimCourseState>(
              builder: (context, state) {
            return !state.loadingCourseStatus.isSuccess
                ? const SpinKitWaveSpinner(
                    color: Colors.lightBlueAccent,
                    size: 50.0,
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: state.swimCourseOptions.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        // height: 50, // Sie können die Höhe nach Bedarf festlegen oder entfernen
                        child: Visibility(
                          visible:
                              true, //state.swimCourseOptions[index].isCourseVisible,
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Colors.lightBlueAccent,
                                groupValue: state.swimCourse.value,
                                value: state.swimCourseOptions[index].name,
                                onChanged: (val) {
                                  // Hier sollte die Auswahl aktualisiert werden
                                  BlocProvider.of<SwimCourseBloc>(context).add(
                                      SwimCourseChanged(val.toString(),
                                          state.swimCourseOptions[index]));
                                },
                              ),
                              Flexible(
                                child: Wrap(
                                  children: [
                                    Text(
                                      '${state.swimCourseOptions[index].name} '
                                      '${state.swimCourseOptions[index].price} €',
                                      overflow: TextOverflow
                                          .visible, // Bei Bedarf können Sie Text Beschneidung hinzufügen
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                // onPressed: () => showCourseDescription(context,
                                // //     index),
                                icon: const Icon(
                                  Icons.info_rounded,
                                  color: Colors.blue,
                                  size: 20,
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
          });
        });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwimCourseBloc, SwimCourseState>(
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
            context.select((SwimCourseBloc bloc) => bloc.state.isValid);
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
                    ? () => context.read<SwimCourseBloc>().add(FormSubmitted())
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
    return BlocBuilder<SwimCourseBloc, SwimCourseState>(
        buildWhen: (previous, current) =>
            previous.submissionStatus != current.submissionStatus,
        builder: (context, state) {
          return state.submissionStatus.isInProgress
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
