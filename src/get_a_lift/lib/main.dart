import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/homePagePassenger.dart';
import 'package:get_a_lift/licenceRequest.dart';
import 'package:get_a_lift/loginPage.dart';
import 'package:get_a_lift/publishTrip.dart';
import 'package:get_a_lift/registerPage.dart';
import 'package:get_a_lift/searchTrip.dart';
import 'package:provider/provider.dart';
import 'driver_preferences_provider.dart';
import 'package:flutter/services.dart';
import 'homePage.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBeaCWjXZNeoj6lj0KI1BU5kOpCVldb_TU',
          appId: '1:936008036598:web:f685fa134b3cb3bb7ffcd7',
          messagingSenderId: '936008036598',
          projectId: 'esof-d7026',
          storageBucket:'esof-d7026.appspot.com' ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(ChangeNotifierProvider(
    create: (_) => DriverPreferencesProvider(), // Add this line to create the provider
    child: MyApp(),
  ),);
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get a lift',
      home: const LoginPage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/licenceRequest' : (context) => const LicenceRequest(),
        '/homePassenger': (context) => const HomePagePassenger(),
      },
    );
  }
}
