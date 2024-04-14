import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_a_lift/registerPage.dart';
import 'package:get_a_lift/homePage.dart';


void main() => runApp(MaterialApp(
  home: loginPage(),
));

class loginPage extends StatelessWidget {
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
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RegisterPage(),
                ));
              },
              child: Text('Sign up here!'),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => homePage(),
                ));
              },
              child: Text('Submit'),
            ),
          )

        ],
      )

    );
  }
}
