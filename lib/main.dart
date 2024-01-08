import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/swim_generator.dart';

void main() {
  //final HttpLink httpLink = HttpLink('https://localhost:7188/graphql');
  final HttpLink httpLink = HttpLink('https://backend.elated-morse.212-227-206-78.plesk.page:5051/graphql');

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );

  runApp(MyApp(graphQLClient: client.value));
}

class MyApp extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const MyApp({super.key, required this.graphQLClient});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(graphQLClient),
      child: BlocProvider(
        create: (_) => ThemeCubit(),
        child: AppView(
          graphQLClient: graphQLClient,
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const AppView({super.key, required this.graphQLClient});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (_, theme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: MyHomePage(
            graphQLClient: graphQLClient,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const MyHomePage({super.key, required this.graphQLClient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF009EE1),
        title: const Text(
          'Schwimmgenerator',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(context
        //         .read<ThemeCubit>()
        //         .currentIcon),
        //     tooltip: 'Brightness',
        //     onPressed: () => context.read<ThemeCubit>().toggleTheme(),
        //   ),
        // ],
      ),
      body: SwimGeneratorPage(
          graphQLClient: graphQLClient,
          title:
              "title"), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/// {@template brightness_cubit}
/// A simple [Cubit] that manages the [ThemeData] as its state.
/// {@endtemplate}
class ThemeCubit extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.white,
    ),
    brightness: Brightness.light,
  );

  static final _darkTheme = ThemeData(
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: Colors.black,
    ),
    brightness: Brightness.dark,
  );

  /// Toggles the current brightness between light and dark.
  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }

  IconData get currentIcon => state.brightness == Brightness.dark
      ? Icons.light_mode_outlined
      : Icons.dark_mode_outlined;
}
