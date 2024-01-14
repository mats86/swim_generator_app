part of 'result_bloc.dart';

class ResultRepository {
  final GraphQLClient graphQLClient;

  ResultRepository({required this.graphQLClient});

  Future<void> executeCreateCompleteSwimCourseBooking(
      CompleteSwimCourseBookingInput input) async {
    final MutationOptions options = MutationOptions(
      document: gql(GraphQLQueries.createCompleteSwimCourseBooking),
      variables: {
        'input': input.toGraphqlJson(),
        // Diese Methode konvertiert das Eingabeobjekt in ein JSON-Format, das für GraphQL geeignet ist.
      },
    );

    final QueryResult result = await graphQLClient.mutate(options);

    if (result.hasException) {
      if (kDebugMode) {
        print(result.exception.toString());
      }
      // Fehlerbehandlung
    } else {
      if (kDebugMode) {
        print('Mutation erfolgreich');
      }
      // Verarbeiten der Antwort
    }
  }
}
