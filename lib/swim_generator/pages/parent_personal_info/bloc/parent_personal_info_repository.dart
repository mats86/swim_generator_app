part of 'parent_personal_info_bloc.dart';

class ParentPersonalInfoRepository {
  Future<List<String>> _fetchTitle() async {
    return <String>['Frau', 'Herr'];
  }
}