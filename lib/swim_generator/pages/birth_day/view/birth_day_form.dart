import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../cubit/swim_generator_cubit.dart';
import '../bloc/birth_day_bloc.dart';

class BirthDayForm extends StatefulWidget {
  const BirthDayForm({super.key, required this.shouldUseFutureBuilder});

  final bool shouldUseFutureBuilder;

  @override
  State<BirthDayForm> createState() => _BirthDayForm();
}

class _BirthDayForm extends State<BirthDayForm> {
  final TextEditingController _birthDayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (context.read<SwimGeneratorCubit>().state.birthDay.birthDay != null) {
      _birthDayController.text = DateFormat('dd.MM.yyyy')
          .format(context.read<SwimGeneratorCubit>().state.birthDay.birthDay!);
      context.read<BirthDayBloc>().add(BirthDayChanged(
          context.read<SwimGeneratorCubit>().state.birthDay.birthDay!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BirthDayBloc, BirthDayState>(
      listener: (context, state) {
        if (state.birthDay.value != null) {
          _birthDayController.text =
              DateFormat('dd.MM.yyyy').format(state.birthDay.value!);
        }
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
          _BirthDataInput(
              controller: _birthDayController,
              shouldUseFutureBuilder: widget.shouldUseFutureBuilder),
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

class _BirthDataInput extends StatelessWidget {
  final TextEditingController controller;
  final bool shouldUseFutureBuilder;

  const _BirthDataInput({
    required this.controller,
    required this.shouldUseFutureBuilder,
  });

  // Define _textField as an instance variable.

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BirthDayBloc, BirthDayState>(
      buildWhen: (previous, current) => previous.birthDay != current.birthDay,
      builder: (context, state) {
        return TextFormField(
          key: const Key('personalInfoForm_birthDayInput_textField'),
          // onChanged: (birthday) => context
          //     .read<BirthDayBloc>()
          //     .add(BirthDayChanged(birthday)),
          controller: controller,
          readOnly: true,
          onTap: () async {
            var datePicked = await DatePicker.showSimpleDatePicker(
              context,
              lastDate: DateTime.now(),
              initialDate: DateTime(2022),
              dateFormat: "dd.MMMM.yyyy",
              locale: DateTimePickerLocale.de,
              looping: false,
              pickerMode: DateTimePickerMode.date,
              //backgroundColor: Colors.lightBlueAccent,
              titleText: "Datum auswählen",
              itemTextStyle: const TextStyle(
                fontSize: 18, // Setzt die Schriftgröße
                color: Colors.black, // Setzt die Textfarbe
                // Weitere Stiloptionen wie fontFamily, fontStyle usw.
              ),
            );
            controller.text = DateFormat('dd.MM.yyyy').format(datePicked!);
            if (context.mounted) {
              context.read<BirthDayBloc>().add(BirthDayChanged(datePicked));
            }
            //Navigator.push(
            //    context, MaterialPageRoute(builder: (_) => WidgetPage()));
          },
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            label: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Text(
                    'Geburtstag des Kindes',
                    style: TextStyle(fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Text(
                    '*',
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ],
              ),
            ),
            errorText:
                state.birthDay.isValid ? state.birthDay.error?.message : null,
          ),
        );
      },
    );
  }
}

// void _showDatePickerDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         insetPadding:
//         EdgeInsets.all(0.0), // Entfernen Sie Padding um den Dialog
//         child: Container(
//           width: MediaQuery.of(context)
//               .size
//               .width, // Setzt die Breite auf die volle Bildschirmbreite
//           height: 200, // Legen Sie eine angemessene Höhe für den Picker fest
//           child: DropdownDatePicker(
//             locale: "de_DE",
//             inputDecoration: InputDecoration(
//                 enabledBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey, width: 1.0),
//                 ),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(10))), // optional
//             isDropdownHideUnderline: true, // optional
//             isFormValidator: true, // optional
//             startYear: 1900, // optional
//             endYear: 2020, // optional
//             width: 10, // optional
//             // selectedDay: 14, // optional
//             selectedMonth: 10, // optional
//             selectedYear: 1993, // optional
//             onChangedDay: (value) => print('onChangedDay: $value'),
//             onChangedMonth: (value) => print('onChangedMonth: $value'),
//             onChangedYear: (value) => print('onChangedYear: $value'),
//             //boxDecoration: BoxDecoration(
//             // border: Border.all(color: Colors.grey, width: 1.0)), // optional
//             // showDay: false,// optional
//             // dayFlex: 2,// optional
//             // locale: "zh_CN",// optional
//             hintDay: 'Day', // optional
//             // hintMonth: 'Month', // optional
//             // hintYear: 'Year', // optional
//             // hintTextStyle: TextStyle(color: Colors.grey), // optional
//           ),
//         ),
//       );
//     },
//   );
// }

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BirthDayBloc, BirthDayState>(
      listenWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus.isSuccess) {
          context.read<SwimGeneratorCubit>().stepContinued();
          context
              .read<SwimGeneratorCubit>()
              .updateBirthDay(state.birthDay.value);
        }
      },
      buildWhen: (previous, current) =>
          previous.submissionStatus != current.submissionStatus,
      builder: (context, state) {
        final isValid =
            context.select((BirthDayBloc bloc) => bloc.state.isValid);
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
                    ? () => context.read<BirthDayBloc>().add(FormSubmitted())
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
    return BlocBuilder<BirthDayBloc, BirthDayState>(
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
                  child: const Text('Zurück'),
                );
        });
  }
}
