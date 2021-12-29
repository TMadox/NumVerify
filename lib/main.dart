import 'package:enterpreware_task/Logic/Provider/general_state_class.dart';
import 'package:enterpreware_task/Logic/Provider/numbers_state_class.dart';
import 'package:enterpreware_task/Misc/scroll_behavior.dart';
import 'package:enterpreware_task/View/Screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:resize/resize.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => NumberState()),
    ChangeNotifierProvider(create: (_) => GeneralState())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Resize(builder: () {
      return MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        supportedLocales: const [
          Locale('de'),
          Locale('en'),
          Locale('es'),
          Locale('fr'),
          Locale('it'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        home: SplashScreen(),
      );
    });
  }
}
