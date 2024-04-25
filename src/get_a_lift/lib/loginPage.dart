import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_a_lift/notifications/toast.dart';
import 'package:get_a_lift/registerPage.dart';
import 'package:get_a_lift/homePage.dart';
import 'package:get_a_lift/widgets/form_container_widget.dart';

import 'firebase_auth_implementation/firebase_auth_services.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade800,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
          'Login',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Poppins',
            fontSize: 50,
            
          ),
        ),

        Padding(
            padding: const EdgeInsets.fromLTRB(100, 100, 100, 8),
            child: TextField(
              controller: _emailController,
              style: TextStyle(
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.white60,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(100, 8, 100, 8),
            child: TextField(
              controller: _passwordController,
              style: TextStyle(
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.white60,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
            child: Text(
              "Don't have an account?",
              style: TextStyle(
                color: Colors.white70,
                
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterPage()),
                        (route) => false);
              },
              child: Text('Sign up here!'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
            child: TextButton(
              onPressed: () {
                _login();
              },
              child: Text('Submit'),
            ),
          )

        ],
      )

    );
  }

  void _login() async{
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.loginWithEmailAndPassword(email, password);

    if (user != null) {
      showToast(message: "User is successfully signed in");
      Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "some error occured");
    }
  }
}
