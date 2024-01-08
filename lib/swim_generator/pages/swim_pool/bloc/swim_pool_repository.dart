part of 'swim_pool_bloc.dart';

class SwimPoolRepository
{
  final GraphQLClient graphQLClient;

  SwimPoolRepository({required this.graphQLClient});

  Future<List<SwimPool>> fetchSwimPools() async {
    final QueryOptions options = QueryOptions(
      document: gql(GraphQLQueries.getSwimPools),
    );

    final result = await graphQLClient.query(options);
    if (result.hasException) {
      throw result.exception!;
    }
    if (result.hasException) {
      // Fehlerbehandlung
      if (kDebugMode) {
        print(result.exception.toString());
      }
      return [];
    }

    if (result.data == null || result.data!['swimPools'] == null) {
      // Behandeln Sie den Fall, wenn keine Daten vorhanden sind
      if (kDebugMode) {
        print("Keine Daten gefunden");
      }
      return [];
    }

    List<dynamic> swimPoolsJson = result.data!['swimPools'];
    // Konvertieren Sie jeden JSON-Eintrag in ein SwimPool-Objekt
    return swimPoolsJson.map((json) => SwimPool.fromJson(json)).toList();
  }

}