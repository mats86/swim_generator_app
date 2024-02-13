import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:swim_generator_app/swim_generator/pages/swim_level/bloc/swim_level_bloc.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../../../models/swim_level.dart';
import '../models/swim_level_model.dart';
import '../models/swim_season.dart';

class SwimLevelForm extends StatefulWidget {
  final bool isDirectLinks;

  const SwimLevelForm({
    super.key,
    required this.isDirectLinks,
  });

  @override
  State<SwimLevelForm> createState() => _SwimLevelForm();
}

class _SwimLevelForm extends State<SwimLevelForm> {
  String _getReferrer() {
    String referrer = js.context.callMethod('getReferrer');
    return referrer;
  }

  @override
  void initState() {
    super.initState();
    context.read<SwimLevelBloc>().add(IsDirectLinks(widget.isDirectLinks));

    // DateTime now = DateTime(2024, 3, 1, 00, 01);
    DateTime now = DateTime.now();
    int year = now.year;
    DateTime startSeason =
        DateTime(year, 3, 1, 00, 00); // 31.1 23:59 end january
    DateTime endSeason = DateTime(year, 8, 31, 23, 59); // 31.8 23:59 end August

    DateTime startFixDate = DateTime(year, 2, 1, 00, 00);

    context.read<SwimGeneratorCubit>().updateConfigApp(
          isDirectLinks: widget.isDirectLinks,
          isBooking: now.isAfter(startSeason) && now.isBefore(endSeason)
              ? true
              : false,
          isStartFixDate: now.isAfter(startFixDate) && now.isBefore(endSeason)
              ? true
              : false,
          isEmailExists: false,
          referenceBooking: _getReferrer() == ''
              ? 'https://wassermenschen.org/'
              : _getReferrer(),
        );

    SwimLevelEnum swimLevel =
        context.read<SwimGeneratorCubit>().state.swimLevel.swimLevel!;
    if (swimLevel != SwimLevelEnum.UNDEFINED) {
      context.read<SwimLevelBloc>().add(SwimLevelChanged(
          SwimLevelModel.dirty(SwimLevelEnum.values[swimLevel.index])));
    }
    if (context
            .read<SwimGeneratorCubit>()
            .state
            .swimLevel
            .swimSeason
            ?.refDate !=
        null) {
      context.read<SwimLevelBloc>().add(SwimSeasonChanged(
          context.read<SwimGeneratorCubit>().state.swimLevel.swimSeason!.name,
          context.read<SwimGeneratorCubit>().state.swimLevel.swimSeason!,
          widget.isDirectLinks));
    }
  }

  @override
  Widget build(BuildContext context) {
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
          if (!widget.isDirectLinks) ...[
            const SizedBox(
              height: 16.0,
            ),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Wähle bitte Dein Schwimmniveau aus?",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.visible,
            ),
            const SizedBox(
              height: 24.0,
            ),
            const _SwimLevelSelected(),
          ],
          const SizedBox(
            height: 32.0,
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                  text: "Alle unsere Neukunden-Kurse starten im Sommer. "
                      "Bestandkunden-Kurse bieten wir auch ganzjährig Kurse an.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ])),
            ),
          ),
          const SizedBox(
            height: 32.0,
          ),
          _SwimSeasonRadioButton(isDirectLinks: widget.isDirectLinks),
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
  const _SwimLevelSelected();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimLevelBloc, SwimLevelState>(
      buildWhen: (previous, current) =>
          previous.swimLevelModel != current.swimLevelModel,
      builder: (context, state) {
        List<bool> isSelected = [
          state.swimLevelModel.value == SwimLevelEnum.EINSTEIGERKURS,
          state.swimLevelModel.value == SwimLevelEnum.AUFSTEIGERKURS,
        ];

        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildToggleButton(
                  Icons.waves, " EINSTEIGER", isSelected[0], 0, context),
              const SizedBox(width: 8.0),
              _buildToggleButton(
                  Icons.pool, "AUFSTEIGER", isSelected[1], 1, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleButton(IconData icon, String text, bool isSelected,
      int index, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    String buttonText = screenWidth > 500 ? "${text}KURS" : text;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: TextButton(
        onPressed: () => context.read<SwimLevelBloc>().add(SwimLevelChanged(
            SwimLevelModel.dirty(SwimLevelEnum.values[index]))),
        style: TextButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          foregroundColor: isSelected ? Colors.blue : Colors.grey,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
            Text(buttonText,
                style:
                    TextStyle(color: isSelected ? Colors.black : Colors.white)),
          ],
        ),
      ),
    );
  }
}

class _SwimSeasonRadioButton extends StatelessWidget {
  final bool isDirectLinks;

  const _SwimSeasonRadioButton({required this.isDirectLinks});

  @override
  Widget build(BuildContext context) {
    String getSeasonText() {
      if (context.read<SwimGeneratorCubit>().state.configApp.isBooking) {
        context.read<SwimLevelBloc>().add(
              LoadSwimSeasonOptions(
                [
                  SwimSeason(
                    name: 'Für laufenden Sommer Saison buchen',
                    refDate: DateTime(DateTime.now().year, 6, 1),
                    swimSeasonEnum: SwimSeasonEnum.BUCHEN,
                  ),
                  SwimSeason(
                    name:
                        'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 1))} reservieren',
                    refDate: DateTime(DateTime.now().year + 1, 6),
                    swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
                  ),
                  SwimSeason(
                    name:
                        'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 2))} reservieren',
                    refDate: DateTime(DateTime.now().year + 2, 6),
                    swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
                  ),
                  SwimSeason(
                    name:
                        'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 3))} reservieren',
                    refDate: DateTime(DateTime.now().year + 3, 6),
                    swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
                  ),
                ],
              ),
            );
        return 'Möchtest Du in der Kommenden Saison starten?';
      } else {
        context.read<SwimLevelBloc>().add(
              LoadSwimSeasonOptions(
                [
                  SwimSeason(
                    name: 'Buchen/Reservieren für Sommersaison 2024',
                    refDate: DateTime(DateTime.now().year, 6, 1),
                    swimSeasonEnum: SwimSeasonEnum.BUCHEN,
                  ),
                  SwimSeason(
                    name:
                        'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 1))} reservieren',
                    refDate: DateTime(DateTime.now().year + 1, 6),
                    swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
                  ),
                  SwimSeason(
                    name:
                        'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 2))} reservieren',
                    refDate: DateTime(DateTime.now().year + 2, 6),
                    swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
                  ),
                  SwimSeason(
                    name:
                        'Für ${DateFormat('yyyy').format(DateTime(DateTime.now().year + 3))} reservieren',
                    refDate: DateTime(DateTime.now().year + 3, 6),
                    swimSeasonEnum: SwimSeasonEnum.RESERVIEREN,
                  ),
                ],
              ),
            );
        return 'In WELCHER Somersaison möchtest Du starten?';
      }
    }

    return BlocBuilder<SwimLevelBloc, SwimLevelState>(
        builder: (context, state) {
      return Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: getSeasonText(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            overflow: TextOverflow.visible,
          ),
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListView.separated(
                    separatorBuilder: (_, __) =>
                        Divider(color: Colors.grey[300]),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: state.swimSeasonOptions.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        // height: 50,
                        child: Visibility(
                          visible: true,
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Colors.lightBlueAccent,
                                groupValue: state.swimSeason.value,
                                value: state.swimSeasonOptions[index].name,
                                onChanged: (val) {
                                  BlocProvider.of<SwimLevelBloc>(context).add(
                                      SwimSeasonChanged(
                                          val.toString(),
                                          state.swimSeasonOptions[index],
                                          isDirectLinks));
                                },
                              ),
                              Flexible(
                                child: Wrap(
                                  children: [
                                    Text(
                                      '${state.swimSeasonOptions[index].name} ',
                                      overflow: TextOverflow.visible,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
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
          context.read<SwimGeneratorCubit>().updateSwimLevel(
              state.swimLevelModel.value, state.selectedSwimSeason);
          context.read<SwimGeneratorCubit>().updateConfigApp(
              isBooking: state.selectedSwimSeason.swimSeasonEnum ==
                      SwimSeasonEnum.BUCHEN
                  ? true
                  : false);
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
