import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:swim_generator_app/swim_generator/models/swim_level.dart';
import 'package:swim_generator_app/swim_generator/pages/pages.dart';
import 'package:swim_generator_app/swim_generator/pages/result/bloc/result_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../models/models.dart';

class ResultForm extends StatefulWidget {
  const ResultForm({super.key});

  @override
  State<ResultForm> createState() => _ResultForm();
}

class _ResultForm extends State<ResultForm> {
  @override
  void initState() {
    super.initState();
    context.read<ResultBloc>().add(ResultLoading(context
            .read<SwimGeneratorCubit>()
            .state
            .swimLevel
            .swimSeason
            ?.swimSeasonEnum ==
        SwimSeasonEnum.BUCHEN));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResultBloc, ResultState>(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _CustomHeader('DATEN SCHWIMMSCHÜLER:IN'),
          _CustomText(
            'Name',
            '${context.read<SwimGeneratorCubit>().state.kindPersonalInfo.firstName} '
                '${context.read<SwimGeneratorCubit>().state.kindPersonalInfo.lastName}',
          ),
          _CustomText(
            'Geburtstag',
            DateFormat('dd.MM.yyy').format(
                context.read<SwimGeneratorCubit>().state.birthDay.birthDay!),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const _CustomHeader('DATEN ERZIEHUNGSBERECHTIGTER'),
          _CustomText(
            'Name',
            '${context.read<SwimGeneratorCubit>().state.personalInfo.firstName} '
                '${context.read<SwimGeneratorCubit>().state.personalInfo.lastName}',
          ),
          _CustomText(
            'Adress',
            '${context.read<SwimGeneratorCubit>().state.personalInfo.parentStreet} '
                '${context.read<SwimGeneratorCubit>().state.personalInfo.streetNumber}, '
                '${context.read<SwimGeneratorCubit>().state.personalInfo.zipCode}, '
                '${context.read<SwimGeneratorCubit>().state.personalInfo.city}',
          ),
          _CustomText(
            'E-Mail',
            '${context.read<SwimGeneratorCubit>().state.personalInfo.email} ',
          ),
          _CustomText(
            'Handynummer',
            '${context.read<SwimGeneratorCubit>().state.personalInfo.phoneNumber} ',
          ),
          const SizedBox(
            height: 12.0,
          ),
          const _CustomHeader('Gebuchter KURS/BAD'),
          _CustomText(
            'Kurs',
            '${context.read<SwimGeneratorCubit>().state.swimCourseInfo.swimCourse.swimCourseName} '
                '${context.read<SwimGeneratorCubit>().state.swimCourseInfo.swimCourse.swimCoursePrice} €',
          ),
          _CustomText(
              'Schwimmbäder',
              context
                  .read<SwimGeneratorCubit>()
                  .state
                  .swimPools
                  .map((e) => e.swimPoolName)
                  .join(', ')),
          const Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: context.read<SwimGeneratorCubit>().state.configApp.isBooking
                ? const Text(
                    "Du erhältst in den nächsten 30 min eine Email als "
                    "ANMELDEBESTÄTIGUNG mit obigen Daten. Entsprechend "
                    "deiner gebuchten Kurse wirst Du zur ANZAHLUNG "
                    "aufgefordert. Die Höhe der Anzahlung liegt bei Kursen "
                    "unter €150 bei €50. Bei Kursen ÜBER € 150 bei €100. "
                    "Die Zahlung muss innerhalb 7 Werktagen auf unserem "
                    "Konto verbucht sein. ANDERNFALLS WÜRDEN WIR DEINE "
                    "BUCHUNG WIEDER STORNIEREN, den Platz für Andere "
                    "freigeben.",
                  )
                : Column(
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Wir nehmen Monaten vor den eigentlichen '
                                    'Kurstermin keine Buchungen entgegen.'
                                    '\n\n'),
                            TextSpan(
                                text: '1. ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'es ist nicht absehbar wie sich ein Kind '
                                    'in den nächsten Monaten entwickelt. 6 '
                                    'Monate sehen wir als max. überschaubaren '
                                    'Zeitraum.\n'),
                            TextSpan(
                                text: '2. ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: 'Buchungen die nicht mit Anzahlungen '
                                    '(bis zu €100) verbunden sind führen '
                                    'dazu, '
                                    'dass sich Schwimmkurssuchende in '
                                    'vielen Schwimmschulen anmelden - was '
                                    'allerdings viel Chaos stiftet. '
                                    'Zum Zeitpunkt des Kurses kommt nicht mehr '
                                    'mal die Hälfte der angemeldeten.\n\n'),
                            TextSpan(
                                text: 'Um dir ein wenig Flexibilität zu '
                                    'geben, aber dennoch bereits ein '
                                    'RESERVIERUNG '
                                    'platzieren zu können - auch Jahre im '
                                    'Voraus, kannst du Mitglied im '
                                    'Wassermenschen-Verein ab '
                                    '€10 werden. Dort reservieren wir Dir '
                                    'jährlich bis 1.3. einen Platz den '
                                    'du dann in eine verbindliche '
                                    'Buchung umwandeln kannst. FIX BUCHEN '
                                    'kannst Du bei deiner Schwimmschule '
                                    'ab dem 1.2. jeden Jahres für '
                                    'den kommenden Sommer. Reservierung haben '
                                    'natürlich Vorrang - reduzieren somit '
                                    'die Anzahl der dann buchbaren Plätze.\n'),
                          ],
                        ),
                      ),
                      const _LinkTextWidget(),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 16),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Zweck des Vereins gemäß seiner Satzung '
                                    'ist es zum einen eben dieses '
                                    'Reservierungsportal zu unterhalten. '
                                    'Und 2. die Schwimmmethode '
                                    '#angstfreiSchwimmenLernen '
                                    'in der Presse und den '
                                    'Socialen Medien zu verbreiten. '
                                    'Wir freuen uns auf Deine Unterstützung '
                                    'und deine Reservierung.\n')
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          const Row(
            children: [
              Text(
                'Bestätigung ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '*',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Center(
            child: Row(
              children: <Widget>[
                BlocBuilder<ResultBloc, ResultState>(
                  builder: (context, state) {
                    return Checkbox(
                      activeColor: Colors.lightBlueAccent,
                      value: state.isConfirmed.value,
                      onChanged: (val) {
                        context.read<ResultBloc>().add(ConfirmedChanged(val!));
                      },
                    );
                  },
                ),
                const Expanded(
                  child: Text(
                    'Mir ist bewusst, dass ich bis zu 30 Minuten Anfahrt '
                    'in Kauf nehmen muss.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          BlocBuilder<ResultBloc, ResultState>(
            builder: (context, state) {
              return Visibility(
                visible: context
                    .read<SwimGeneratorCubit>()
                    .state
                    .configApp
                    .isBooking,
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Stornierung ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Center(
                      child: Row(
                        children: <Widget>[
                          BlocBuilder<ResultBloc, ResultState>(
                            builder: (context, state) {
                              return Checkbox(
                                activeColor: Colors.lightBlueAccent,
                                value: state.isCancellation.value,
                                onChanged: (val) {
                                  context
                                      .read<ResultBloc>()
                                      .add(CancellationChanged(val!));
                                },
                              );
                            },
                          ),
                          const Expanded(
                            child: Text(
                              'Bei Stornierung nach dem 28.02. verfällt die Anzahlung.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              );
            },
          ),
          const Row(
            children: [
              Text(
                'DSGVO-Einverständnis ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '*',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Center(
            child: Row(
              children: <Widget>[
                BlocBuilder<ResultBloc, ResultState>(
                  builder: (context, state) {
                    return Checkbox(
                      activeColor: Colors.lightBlueAccent,
                      value: state.isConsentGDPR.value,
                      onChanged: (val) {
                        context
                            .read<ResultBloc>()
                            .add(ConsentGDPRChanged(val!));
                      },
                    );
                  },
                ),
                const Expanded(
                  child: Text(
                    'Ich willige ein, dass diese Website meine übermittelten '
                    'Informationen speichert, sodass meine Anfrage '
                    'beantwortet werden kann.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
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

class _CustomText extends StatelessWidget {
  const _CustomText(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomHeader extends StatelessWidget {
  const _CustomHeader(this.header);

  final String header;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Text(
        header,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResultBloc, ResultState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          //context.read<SwimGeneratorCubit>().stepContinued();
          _showSuccessDialog(context);
        }
      },
      buildWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        bool isDataValid() {
          var cubit = context.read<SwimGeneratorCubit>().state;
          return cubit.swimLevel.isNotEmpty &&
              cubit.birthDay.isNotEmpty &&
              cubit.swimCourseInfo.isNotEmpty &&
              cubit.swimPools.isNotEmpty &&
              cubit.personalInfo.isNotEmpty &&
              cubit.kindPersonalInfo.isNotEmpty;
        }

        CompleteSwimCourseBookingInput? bookingInput;
        VereinInput? vereinInput;
        if (isDataValid()) {
          bookingInput = CompleteSwimCourseBookingInput(
            loginEmail:
                context.read<SwimGeneratorCubit>().state.personalInfo.email,
            firstName:
                context.read<SwimGeneratorCubit>().state.personalInfo.firstName,
            lastName:
                context.read<SwimGeneratorCubit>().state.personalInfo.lastName,
            address:
                '${context.read<SwimGeneratorCubit>().state.personalInfo.parentStreet} '
                '${context.read<SwimGeneratorCubit>().state.personalInfo.streetNumber}, '
                '${context.read<SwimGeneratorCubit>().state.personalInfo.zipCode} '
                '${context.read<SwimGeneratorCubit>().state.personalInfo.city}',
            phoneNumber: context
                .read<SwimGeneratorCubit>()
                .state
                .personalInfo
                .phoneNumber,
            studentFirstName: context
                .read<SwimGeneratorCubit>()
                .state
                .kindPersonalInfo
                .firstName,
            studentLastName: context
                .read<SwimGeneratorCubit>()
                .state
                .kindPersonalInfo
                .lastName,
            birthDate:
                context.read<SwimGeneratorCubit>().state.birthDay.birthDay!,
            swimCourseID: context
                .read<SwimGeneratorCubit>()
                .state
                .swimCourseInfo
                .swimCourse
                .swimCourseID,
            swimPoolIDs: context
                .read<SwimGeneratorCubit>()
                .state
                .swimPools
                .map((pool) => pool.swimPoolID)
                .toList(),
            referenceBooking: context
                .read<SwimGeneratorCubit>()
                .state
                .configApp
                .referenceBooking,
            bookingDateTypID: context
                .read<SwimGeneratorCubit>()
                .state
                .dateSelection
                .bookingDateTypID,
            fixDateID: context
                        .read<SwimGeneratorCubit>()
                        .state
                        .dateSelection
                        .bookingDateTypID ==
                    2
                ? context
                    .read<SwimGeneratorCubit>()
                    .state
                    .dateSelection
                    .fixDate
                    .fixDateID
                : null,
            desiredDateTimes: context
                .read<SwimGeneratorCubit>()
                .state
                .dateSelection
                .dateTimes,
            isAdult: context
                .read<SwimGeneratorCubit>()
                .state
                .swimCourseInfo
                .swimCourse
                .isAdultCourse,
            isGroupCourse: context
                .read<SwimGeneratorCubit>()
                .state
                .swimCourseInfo
                .swimCourse
                .isGroupCourse,
          );
        }

        final isValid = context.select((ResultBloc bloc) => bloc.state.isValid);
        return state.submissionStatus.isInProgress
            ? const SpinKitWaveSpinner(
                color: Colors.lightBlueAccent,
                size: 50.0,
              )
            : ElevatedButton(
                key: const Key(
                    'ParentPersonalInfoForm_submitButton_elevatedButton'),
                style: ElevatedButton.styleFrom(
                    elevation: 0, backgroundColor: Colors.lightBlueAccent),
                onPressed: isValid
                    ? () {
                        if (context
                            .read<SwimGeneratorCubit>()
                            .state
                            .configApp
                            .isBooking) {
                          context.read<ResultBloc>().add(FormSubmitted(
                              bookingInput!,
                              context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .configApp
                                  .isEmailExists));
                        } else {
                          vereinInput = VereinInput(
                              panrede: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .personalInfo
                                  .parentTitle,
                              pvorname: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .personalInfo
                                  .firstName,
                              pname: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .personalInfo
                                  .lastName,
                              pstrasse:
                                  '${context.read<SwimGeneratorCubit>().state.personalInfo.parentStreet} '
                                  '${context.read<SwimGeneratorCubit>().state.personalInfo.streetNumber}',
                              pplz: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .personalInfo
                                  .zipCode,
                              port: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .personalInfo
                                  .city,
                              pmobil: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .personalInfo
                                  .phoneNumber,
                              pemail: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .personalInfo
                                  .email,
                              pgebdatum: DateFormat('yyyy-MM-dd').format(context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .birthDay
                                  .birthDay!),
                              pcfield1: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .swimLevel
                                  .swimSeason!
                                  .refDate!
                                  .year
                                  .toString(),
                              pcfield2: context
                                          .read<SwimGeneratorCubit>()
                                          .state
                                          .swimLevel
                                          .swimLevel ==
                                      SwimLevelEnum.EINSTEIGERKURS
                                  ? 'Einsteig'
                                  : 'Aufsteig',
                              pcfield3: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .swimCourseInfo
                                  .swimCourse
                                  .swimCourseName,
                              pcfield4: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .swimPools
                                  .map((pool) => pool.swimPoolName)
                                  .join(' - '),
                              pcfield5:
                                  '${context.read<SwimGeneratorCubit>().state.kindPersonalInfo.firstName} ${context.read<SwimGeneratorCubit>().state.kindPersonalInfo.lastName}',
                              pcfield6: context
                                  .read<SwimGeneratorCubit>()
                                  .state
                                  .kindPersonalInfo
                                  .kidsDevelopState
                                  .map((e) => e)
                                  .join(', '));
                          context
                              .read<ResultBloc>()
                              .add(FormSubmittedVerein(vereinInput!));
                        }
                      }
                    : null,
                child:
                    context.read<SwimGeneratorCubit>().state.configApp.isBooking
                        ? const Text(
                            'Kostenpflichtig buchen',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const Text(
                            'Reservieren',
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
    return BlocBuilder<ResultBloc, ResultState>(
        buildWhen: (previous, current) =>
            previous.submissionStatus != current.submissionStatus,
        builder: (context, state) {
          return state.submissionStatus.isInProgress
              ? const SizedBox.shrink()
              : TextButton(
                  key: const Key(
                      'ParentPersonalInfoForm_cancelButton_elevatedButton'),
                  onPressed: () =>
                      context.read<SwimGeneratorCubit>().stepCancelled(),
                  child: const Text('Zurück'),
                );
        });
  }
}

Future<void> _showSuccessDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Anmeldung Erfolgreich'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Ihre Anmeldung wurde erfolgreich abgeschlossen.'),
              Text('Sie werden gleich weitergeleitet.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop(true);
              _launchUrl(context
                  .read<SwimGeneratorCubit>()
                  .state
                  .configApp
                  .referenceBooking);
            },
          ),
        ],
      );
    },
  );
}

Future<void> _launchUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

class _LinkTextWidget extends StatelessWidget {
  const _LinkTextWidget();

  @override
  Widget build(BuildContext context) {
    return Linkify(
      onOpen: (link) async {
        if (!await launchUrl(Uri.parse(link.url))) {
          throw Exception('Could not launch ${link.url}');
        }
      },
      text: "Wenn Du jetzt RESERVIEREN drückst, leiten wir Dich mit samt "
          "deiner Eingaben zum https://WASERMENSCHEN-Verein.de weiter.\n",
      style: const TextStyle(fontSize: 16),
      linkStyle: const TextStyle(color: Colors.blue, fontSize: 16),
    );
  }
}

class MeinLinkTextWidget {
  static TextSpan buildTextSpan(BuildContext context) {
    return TextSpan(
      text:
          "Wenn Du jetzt RESERVIEREN drückst, leiten wir Dich mit samt deiner "
          "Eingaben zum https://WASERMENSCHEN-Verein.de weiter.\n",
      style: const TextStyle(
          color: Colors.blue, decoration: TextDecoration.underline),
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          const url = "https://WASERMENSCHEN-Verein.de";
          if (!await launchUrl(Uri.parse(url))) {
            throw 'Could not launch $url';
          }
        },
    );
  }
}
