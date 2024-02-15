import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';

import '../../../../swim_generator/pages/date_selection/model/model.dart';
import '../bloc/db_fix_date_bloc.dart';

class DbFixDateForm extends StatefulWidget {
  const DbFixDateForm({
    super.key,
  });

  @override
  State<DbFixDateForm> createState() => _DbFixDateForm();
}

class _DbFixDateForm extends State<DbFixDateForm> {
  @override
  void initState() {
    super.initState();
    context.read<DbFixDateBloc>().add(LoadFixDateOptions());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DbFixDateBloc, DbFixDateState>(
      listener: (context, state) {
        if (false) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Something went wrong!')),
            );
        }
      },
      child: const ExpandableListViewPage(),
    );
  }
}

class ExpandableListViewPage extends StatelessWidget {
  const ExpandableListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DbFixDateBloc, DbFixDateState>(
        builder: (context, state) {
      return !state.loadingFixDateStatus.isSuccess
          ? const SpinKitWaveSpinner(
              color: Colors.lightBlueAccent,
              size: 50.0,
            )
          : Scaffold(
              body: SfDataGrid(
                source: FixDateDataSource(fixDateData: state.fixDateOptions),
                //columnWidthMode: ColumnWidthMode.fill,
                columns: <GridColumn>[
                  GridColumn(
                      columnName: 'fixDateID',
                      label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text('ID'),
                      )),
                  GridColumn(
                      columnName: 'swimPoolID',
                      label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text('PoolID'),
                      )),
                  GridColumn(
                      columnName: 'swimCourseID',
                      label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text('CourseID'),
                      )),
                  GridColumn(
                      columnName: 'fixDateFrom',
                      label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text('From'),
                      )),
                  GridColumn(
                      columnName: 'fixDateTo',
                      label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text('To'),
                      )),
                  GridColumn(
                      columnName: 'isFixDateActive',
                      label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text('isActive'),
                      )),
                ],
              ),
            );
    });
  }
}

class FixDateDataSource extends DataGridSource {
  /// Erstellt die FixDateDataSource Klasse mit erforderlichen Details.
  FixDateDataSource({required List<FixDateDetail> fixDateData}) {
    _fixDateData = fixDateData
        .map<DataGridRow>((fixDate) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'fixDateID', value: fixDate.fixDateID),
              DataGridCell<String>(
                  columnName: 'swimPoolID', value: fixDate.swimPoolName),
              DataGridCell<String>(
                  columnName: 'swimCourseID', value: fixDate.swimCourseName),
              DataGridCell<DateTime?>(
                  columnName: 'fixDateFrom', value: fixDate.fixDateFrom),
              DataGridCell<DateTime?>(
                  columnName: 'fixDateTo', value: fixDate.fixDateTo),
              DataGridCell<bool>(
                  columnName: 'isFixDateActive',
                  value: fixDate.isFixDateActive),
            ]))
        .toList();
  }

  List<DataGridRow> _fixDateData = [];

  @override
  List<DataGridRow> get rows => _fixDateData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
