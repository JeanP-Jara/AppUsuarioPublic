import 'package:app_all_one/Provider/ProviderAcces.dart';
import 'package:app_all_one/Routes/Pages.dart';
import 'package:app_all_one/Theme/Theme.dart';
import 'package:app_all_one/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    ChangeNotifierProvider(
      create: (_) => AccesProvider(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeChanger(ThemeData.dark()),
        child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeChanger theme = Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Usuario',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: false
      ),
      initialRoute: Routes.INFO,
      routes: appRoutes(),
    );
  }
}




