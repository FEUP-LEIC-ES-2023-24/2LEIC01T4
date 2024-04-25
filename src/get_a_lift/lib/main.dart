import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/licenceRequest.dart';
import 'package:get_a_lift/loginPage.dart';
import 'package:get_a_lift/publishTrip.dart';
import 'package:get_a_lift/registerPage.dart';
import 'package:get_a_lift/searchTrip.dart';
import 'homePage.dart';


Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get a lift',
      home: LoginPage(),
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomePage(),
        '/licenceRequest' : (context) => LicenceRequest(),
      },
    );
  }
}
