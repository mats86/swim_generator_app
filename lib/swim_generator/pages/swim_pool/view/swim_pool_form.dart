import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:swim_generator_app/swim_generator/models/models.dart';

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
    context.read<SwimPoolBloc>().add(LoadFixDates());

    if (context.read<SwimGeneratorCubit>().state.swimPools.isNotEmpty) {
      for (var swimPool in context.read<SwimGeneratorCubit>().state.swimPools) {
        BlocProvider.of<SwimPoolBloc>(context).add(
            SwimPoolOptionToggled(swimPool.swimPool.index,
            swimPool.swimPool.isSelected
        ),
    );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController desiredDateController1 =
        TextEditingController();
    final TextEditingController desiredTimeController1 =
        TextEditingController();
    final TextEditingController desiredDateController2 =
        TextEditingController();
    final TextEditingController desiredTimeController2 =
        TextEditingController();
    final TextEditingController desiredDateController3 =
        TextEditingController();
    final TextEditingController desiredTimeController3 =
        TextEditingController();
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
          _FlexFixDateSelected(),
          const SizedBox(
            height: 16,
          ),
          _SwimCourseRadioButton(),
          DesiredDateTimeInput(
            dateController: desiredDateController1,
            timeController: desiredTimeController1,
            title: 'Wunschtermin 1',
          ),
          const SizedBox(
            height: 16,
          ),
          DesiredDateTimeInput(
            dateController: desiredDateController2,
            timeController: desiredTimeController2,
            title: 'Wunschtermin 2',
          ),
          const SizedBox(
            height: 16,
          ),
          DesiredDateTimeInput(
            dateController: desiredDateController3,
            timeController: desiredTimeController3,
            title: 'Wunschtermin 3',
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

class _FlexFixDateSelected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double xAlign;
    Color loginColor;
    Color signInColor;
    const double width = 300.0;
    const double height = 50.0;
    const double flexDateAlign = -1;
    const double fixDateAlign = 1;
    const Color selectedColor = Colors.white;
    const Color normalColor = Colors.black54;
    xAlign = flexDateAlign;
    loginColor = selectedColor;
    signInColor = normalColor;
    return BlocBuilder<SwimPoolBloc, SwimPoolState>(builder: (context, state) {
      if (state.flexFixDate) {
        // FlexTermin ist ausgewählt
        xAlign = fixDateAlign; // fixDateAlign
        loginColor = Colors.black54;
        signInColor = Colors.white;
      } else {
        xAlign = flexDateAlign; // flexDateAlign
        loginColor = Colors.white;
        signInColor = Colors.black54;
        // FixTermin ist ausgewählt
      }
      return Visibility(
        visible: state.hasFixedDate,
        child: Center(
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(
                Radius.circular(50.0),
              ),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  alignment: Alignment(xAlign, 0),
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    width: width * 0.5,
                    height: height,
                    decoration: const BoxDecoration(
                      color: Color(0xFF009EE1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(50.0),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<SwimPoolBloc>(context)
                        .add(SelectFlexDate());
                  },
                  child: Align(
                    alignment: const Alignment(-1, 0),
                    child: Container(
                      width: width * 0.5,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        'FLEXTERMIN',
                        style: TextStyle(
                          color: loginColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<SwimPoolBloc>(context).add(SelectFixDate());
                  },
                  child: Align(
                    alignment: const Alignment(1, 0),
                    child: Container(
                      width: width * 0.5,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        'FIXTERMIN',
                        style: TextStyle(
                          color: signInColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class DesiredDateTimeInput extends StatelessWidget {
  final TextEditingController dateController;
  final TextEditingController timeController;
  final String title;

  const DesiredDateTimeInput({
    super.key,
    required this.dateController,
    required this.timeController,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimPoolBloc, SwimPoolState>(
      builder: (context, state) {
        if (!state.flexFixDate) {
          dateController.text = '';
          timeController.text = '';
        }
        return Visibility(
          visible: state.flexFixDate,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    const Text('*',
                        style: TextStyle(color: Colors.red, fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dateController,
                        readOnly: true,
                        onTap: () async {
                          await _selectDate(context);
                          await _selectTime(context);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Datum',
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Abstand zwischen den Feldern
                    Expanded(
                      child: TextField(
                        controller: timeController,
                        readOnly: true,
                        onTap: () async {
                          await _selectTime(context);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Uhrzeit',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await DatePicker.showSimpleDatePicker(
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

    if (pickedDate != null) {
      var formattedDate = DateFormat('dd.MM.yyyy').format(pickedDate);
      dateController.text = formattedDate;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      // Eigene Formatierung für das 24-Stunden-Format
      var formattedTime = _formatTimeOfDay(pickedTime);
      timeController.text = formattedTime;
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.Hm(); // Verwenden des 24-Stunden-Formats
    return format.format(dt);
  }
}

class _SwimCourseRadioButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimPoolBloc, SwimPoolState>(builder: (context, state) {
      return !state.loadingFixDates.isSuccess
          ? const SpinKitWaveSpinner(
              color: Colors.lightBlueAccent,
              size: 50.0,
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: state.fixDates.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  // height: 50, // Sie können die Höhe nach Bedarf festlegen oder entfernen
                  child: Visibility(
                    visible:
                        state.fixDates[index].swimPoolID == state.swimPools[index].swimPoolID,
                    child: Row(
                      children: [
                        Radio(
                          activeColor: Colors.lightBlueAccent,
                          groupValue: state.fixDates[index],
                          value: state.fixDates[index].fixDateFrom,
                          onChanged: (val) {
                            // BlocProvider.of<SwimPoolBloc>(context).add(
                            //     SwimPoolModelsChanged(val.toString(),
                            //         state.swimCourseOptions[index]));
                          },
                        ),
                        Flexible(
                          child: Wrap(
                            children: [
                              Text(
                                '${DateFormat('dd.MM').format(state.fixDates[index].fixDateFrom)}'
                                '- ${DateFormat('dd.MM').format(state.fixDates[index].fixDateTo)}',
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
          List<SwimPoolInfo> swimPools = [];
          for (var swimPool in state.swimPools) {
            if (swimPool.isSelected) {
              swimPools.add(SwimPoolInfo(
                  swimPool: swimPool,
                  swimPoolID: swimPool.swimPoolID,
                  swimPoolName: swimPool.swimPoolName));
            }
          }
          context.read<SwimGeneratorCubit>().updateSwimPoolInfo(swimPools);
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
