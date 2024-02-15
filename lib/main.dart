import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:swim_generator_app/db_manager/pages/db_fix_date/view/db_fix_date_page.dart';
import 'package:swim_generator_app/db_manager/pages/db_swim_course/view/db_swim_course_page.dart';
import 'package:swim_generator_app/db_manager/view/db_manager_page.dart';
import 'package:swim_generator_app/swim_generator/swim_generator.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';
import 'auth/pages/login/view/login_page.dart';
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
    int swimCourseID = 0;
    bool isDirectLinks = true;

    Uri uri = Uri.parse(settings.name!);
    String? code = uri.queryParameters['code'];

    switch (uri.path) {
      case '/':
        mode = SpecialFeatureMode.disabled;
        title = 'KURSFINDER';
        isDirectLinks = false;
        break;
      case '/minis':
        mode = SpecialFeatureMode.minis;
        swimCourseID = SpecialFeatureMode.minis.index;
        break;
      case '/modul0':
        mode = SpecialFeatureMode.modul0;
        swimCourseID = SpecialFeatureMode.modul0.index;
        break;
      case '/schnupper_modul':
        mode = SpecialFeatureMode.schnupperModul;
        swimCourseID = SpecialFeatureMode.schnupperModul.index;
        break;
      case '/basic_3x3':
        mode = SpecialFeatureMode.basic_3x3;
        swimCourseID = SpecialFeatureMode.basic_3x3.index;
        break;
      case '/seepferdchen_ferien_pfingsten':
        mode = SpecialFeatureMode.seepferdchenFerienPfingsten;
        swimCourseID = SpecialFeatureMode.seepferdchenFerienPfingsten.index;
        break;
      case '/seepferdchen_ferien_sommer':
        mode = SpecialFeatureMode.seepferdchenFerienSommer;
        swimCourseID = SpecialFeatureMode.seepferdchenFerienSommer.index;
        break;
      case '/better_swim':
        mode = SpecialFeatureMode.betterSwim;
        swimCourseID = SpecialFeatureMode.betterSwim.index;
        break;
      case '/better_swim2':
        mode = SpecialFeatureMode.betterSwim2;
        swimCourseID = SpecialFeatureMode.betterSwim2.index;
        break;
      case '/summer_class':
        mode = SpecialFeatureMode.summerClass;
        swimCourseID = SpecialFeatureMode.summerClass.index;
        break;
      case '/privatkurs_kind':
        mode = SpecialFeatureMode.privatkursKind;
        swimCourseID = SpecialFeatureMode.privatkursKind.index;
        break;
      case '/privatkurs_erwachsen':
        mode = SpecialFeatureMode.privatkursErwachsen;
        swimCourseID = SpecialFeatureMode.privatkursErwachsen.index;
        break;
      case '/privatkurs_kind2':
        mode = SpecialFeatureMode.privatkursKind2;
        swimCourseID = SpecialFeatureMode.privatkursKind2.index;
        break;
      case '/privatkurs_erwachsen2':
        mode = SpecialFeatureMode.privatkursErwachsen2;
        swimCourseID = SpecialFeatureMode.privatkursErwachsen2.index;
        break;
      case '/freundes3_kurs':
        mode = SpecialFeatureMode.freundes3Kurs;
        swimCourseID = SpecialFeatureMode.freundes3Kurs.index;
        break;
      case '/freundes3_kurs2':
        mode = SpecialFeatureMode.freundes3Kurs2;
        swimCourseID = SpecialFeatureMode.freundes3Kurs2.index;
        break;
      case '/eltern_kind_kurs':
        mode = SpecialFeatureMode.elternKindKurs;
        swimCourseID = SpecialFeatureMode.elternKindKurs.index;
        break;
      case '/eltern_lehren_swim':
        mode = SpecialFeatureMode.elternLehrenSwim;
        swimCourseID = SpecialFeatureMode.elternLehrenSwim.index;
        break;
      case '/codeKidsCourse':
        mode = SpecialFeatureMode.codeKidsCourse;
        isDirectLinks = true;
        break;
      case '/codeAdultsCourse':
        mode = SpecialFeatureMode.codeAdultsCourse;
        isDirectLinks = true;
        break;
      case '/db':
        return MaterialPageRoute(
            builder: (context) => DbManagerPage(graphQLClient: graphQLClient));
      case '/db_swim_course':
        return MaterialPageRoute(
            builder: (context) => DbSwimCoursePage(
                  graphQLClient: graphQLClient,
                ));
      case '/db_fix_date':
        return MaterialPageRoute(
            builder: (context) => DbFixDatePage(
                  graphQLClient: graphQLClient,
                ));
      case '/login':
        return MaterialPageRoute(
            builder: (context) => LoginPage(
                  graphQLClient: graphQLClient,
                ));
      default:
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => MyHomePage(
            graphQLClient: graphQLClient,
            title: title,
            specialFeatureMode: SpecialFeatureMode.disabled,
            swimCourseID: 0,
            isDirectLinks: false,
          ),
        );
    }

    page = MyHomePage(
      graphQLClient: graphQLClient,
      title: title,
      specialFeatureMode: mode,
      swimCourseID: swimCourseID,
      isDirectLinks: isDirectLinks,
    );

    return MaterialPageRoute(builder: (_) => page);
  }
}

class MyHomePage extends StatelessWidget {
  final GraphQLClient graphQLClient;
  final String title;
  final SpecialFeatureMode specialFeatureMode;
  final List<int> order;
  final int swimCourseID;
  final bool isDirectLinks;

  MyHomePage({
    super.key,
    required this.graphQLClient,
    this.title = 'Schwimmgenerator',
    this.specialFeatureMode = SpecialFeatureMode.disabled,
    this.swimCourseID = 0,
    this.isDirectLinks = true,
  }) : order = _generateOrder(specialFeatureMode);

  static List<int> _generateOrder(SpecialFeatureMode mode) {
    switch (mode) {
      case SpecialFeatureMode.codeKidsCourse:
        return [0, 1, 5, 6, 7];
      case SpecialFeatureMode.codeAdultsCourse:
        return [0, 1, 6, 7];
      case SpecialFeatureMode.minis:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.modul0:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.schnupperModul:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.basic_3x3:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.seepferdchenFerienPfingsten:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.seepferdchenFerienSommer:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.betterSwim:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.betterSwim2:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.summerClass:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.privatkursKind:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.privatkursErwachsen:
        return [0, 1, 3, 5, 6, 7];
      case SpecialFeatureMode.privatkursKind2:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.privatkursErwachsen2:
        return [0, 1, 3, 5, 6, 7];
      case SpecialFeatureMode.freundes3Kurs:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.freundes3Kurs2:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.elternKindKurs:
        return [0, 1, 3, 4, 5, 6, 7];
      case SpecialFeatureMode.elternLehrenSwim:
        return [0, 1, 3, 4, 5, 6, 7];
      default:
        return [0, 1, 2, 3, 4, 5, 6, 7]; // default
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
      ),
      body: SwimGeneratorPage(
        graphQLClient: graphQLClient,
        title: title,
        order: order,
        swimCourseID: swimCourseID,
        isDirectLinks: isDirectLinks,
      ),
    );
  }
}
