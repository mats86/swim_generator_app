import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:swim_generator_app/swim_generator/pages/result/bloc/result_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../cubit/swim_generator_cubit.dart';

class ResultForm extends StatelessWidget {
  const ResultForm({super.key});

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
          const _CustomHeader('Kind Information'),
          _CustomText(
              'Name', ''
              // '${user.kidsPersonalInfo.firstName} '
              //     '${user.kidsPersonalInfo.lastName}',
          ),
          _CustomText('Geburtstag', ''
              // DateFormat('dd.MM.yyy').format(user.birthDay.birthDay!),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const _CustomHeader('Erziehungsberechtigten Information'),
          _CustomText(
              'Name', ''
              // '${user.personalInfo.firstName} '
              //     '${user.personalInfo.lastName}',
          ),
          _CustomText(
              'Adress', ''
              // '${user.personalInfo.street} '
              //     '${user.personalInfo.streetNumber}, '
              //     '${user.personalInfo.zipCode}, '
              //     '${user.personalInfo.city}',
          ),
          _CustomText('E-Mail', ''
            // '${user.personalInfo.email} ',
          ),
          _CustomText('Handynummer', ''
              // '${user.personalInfo.phoneNumber} ',
          ),
          const SizedBox(
            height: 12.0,
          ),
          const _CustomHeader('Kurs Information'),
          _CustomText(
              'Kurs:', ''
              // '${user.swimCourseInfo.swimCourseName} '
              //     '${user.swimCourseInfo.swimCoursePrice} €',
          ),
          _CustomText(
              'Schwimmbäder', ''
              // user.swimPools
              //     .map((swimPool) => swimPool.swimPoolName)
              //     .join(', '),
    ),
          const Divider(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Mit Deiner Anmeldebestätigung (Email) erhältst Du eine "
              "Aufforderung zur Überweisung der Anzahlung von 100€. "
              "Dieser Betrag muss innerhalb 7 Werktagen bei uns verbucht "
              "sein. Andernfalls würden wir den Kursplatz wieder "
              "freigeben - Deine Buchung stornieren.",
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
          const Row(
            children: [
              Text(
                'Stornierung ',
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
                    ? () => context.read<ResultBloc>().add(FormSubmitted())
                    : null,
                child: const Text(
                  'Kostenpflichtig buchen',
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

// Funktion zum Anzeigen des Erfolgsdialogs
Future<void> _showSuccessDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    // Der Benutzer muss den Button drücken, um den Dialog zu schließen
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
              Navigator.of(dialogContext).pop(); // Schließt den Dialog
              Navigator.of(context).pop(true);
              _launchUrl();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _launchUrl() async {
  final Uri url = Uri.parse('https://wassermenschen.org/');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
