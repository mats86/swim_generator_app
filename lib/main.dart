import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/swim_generator.dart';

enum SpecialFeatureMode {
  disabled,
  mode1,
  mode2,
  // Weitere Modi hier
}

void main() {
  final HttpLink httpLink = HttpLink('https://localhost:7188/graphql');
  // final HttpLink httpLink = HttpLink('https://10.0.2.2:7188/graphql');
  // final HttpLink httpLink = HttpLink(
  //     'https://backend.elated-morse.212-227-206-78.plesk.page:5051/graphql');

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
          onGenerateRoute: _generateRoute,
          debugShowCheckedModeBanner: false,
          theme: theme,
        );
      },
    );
  }

  Route _generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case '/':
        page = MyHomePage(
          graphQLClient: graphQLClient,
          specialFeatureMode: SpecialFeatureMode.disabled,
        );
        break;
      case '/index1':
        page = MyHomePage(
          graphQLClient: graphQLClient,
          specialFeatureMode: SpecialFeatureMode.mode1,
        );
        break;
    // Hier können Sie weitere Fälle für andere Routen hinzufügen
      default:
        page = MyHomePage(graphQLClient: graphQLClient); // Fallback-Seite
    }

    return MaterialPageRoute(builder: (_) => page);
  }
}

class MyHomePage extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final SpecialFeatureMode specialFeatureMode;

  const MyHomePage({
    super.key,
    required this.graphQLClient,
    this.specialFeatureMode = SpecialFeatureMode.disabled,
  });

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
