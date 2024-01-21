import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/swim_generator/swim_generator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'models/special_feature_mode.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy(); // Setzt die URL-Strategie auf Path-basiert um
  // final HttpLink httpLink = HttpLink('https://localhost:7188/graphql');
  final HttpLink httpLink = HttpLink(
      'https://backend.elated-morse.212-227-206-78.plesk.page:5051/graphql');

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    ),
  );
  WebViewPlatform.instance = WebWebViewPlatform();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(graphQLClient: client.value));
}

class MyApp extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const MyApp({super.key, required this.graphQLClient});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: ValueNotifier(graphQLClient),
      child: AppView(
        graphQLClient: graphQLClient,
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final GraphQLClient graphQLClient;

  const AppView({super.key, required this.graphQLClient});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.mandyRed),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.light,
    );
  }

  String capitalize(String text) {
    if (text.isEmpty) return "";
    return text[0].toUpperCase() + text.substring(1);
  }

  String enumName(SpecialFeatureMode mode) {
    return capitalize(mode.toString().split('.').last);
  }

  Route _generateRoute(RouteSettings settings) {
    Widget page;
    SpecialFeatureMode mode;
    String title = 'BUCHUNGS-TOOL';

    switch (settings.name) {
      case '/':
        mode = SpecialFeatureMode.disabled;
        title = 'KURSFINDER';
        break;
      case '/basic_3x3':
        mode = SpecialFeatureMode.basic_3x3;
        break;
      default:
        mode = SpecialFeatureMode.disabled;
    }

    page = MyHomePage(
      graphQLClient: graphQLClient,
      title: title,
      specialFeatureMode: mode,
    );

    return MaterialPageRoute(builder: (_) => page);
  }
}

class MyHomePage extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final String title;
  final SpecialFeatureMode specialFeatureMode;
  final List<int> order;

  MyHomePage({
    super.key,
    required this.graphQLClient,
    this.title = 'Schwimmgenerator',
    this.specialFeatureMode = SpecialFeatureMode.disabled,
  }) : order = _generateOrder(specialFeatureMode);

  static List<int> _generateOrder(SpecialFeatureMode mode) {
    switch (mode) {
      case SpecialFeatureMode.basic_3x3:
        return [0, 1, 2, 3, 4, 5, 6];
      case SpecialFeatureMode.mode2:
        return [4, 3, 2, 1];
      default:
        return [0, 1, 2, 3, 4, 5, 6]; // default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xFF009EE1),
        title: Text(
          title,
          style: const TextStyle(
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
        title: "title",
        order: order,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}