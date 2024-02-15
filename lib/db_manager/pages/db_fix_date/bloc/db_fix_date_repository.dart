part of 'db_fix_date_bloc.dart';

class DbFixDateRepository {
  final GraphQLClient graphQLClient;

  DbFixDateRepository({required this.graphQLClient});

  Future<List<String>> fetchSwimSeason() async {
    return <String>['Laufender Sommer', 'Kommender Sommer'];
  }

  Future<List<FixDate>> getFixDates() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getFixDates),
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    List<dynamic> coursesJson = result.data!['fixDates'];
    // Konvertieren Sie jeden JSON-Eintrag in ein SwimCourse-Objekt
    return coursesJson.map((json) => FixDate.fromJson(json)).toList();
  }

  Future<List<FixDateDetail>> getFixDatesWithDetails() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getFixDatesWithDetails),
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    List<dynamic> coursesJson = result.data!['fixDatesWithDetails'];
    // Konvertieren Sie jeden JSON-Eintrag in ein SwimCourse-Objekt
    return coursesJson.map((json) => FixDateDetail.fromJson(json)).toList();
  }
}
