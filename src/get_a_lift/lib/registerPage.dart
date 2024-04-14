import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_a_lift/licenceRequest.dart';
import 'package:get_a_lift/loginPage.dart';


void main() => runApp(MaterialApp(
  home: RegisterPage(),
));

class RegisterPage extends StatelessWidget {
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
          'Sign Up',
          style: TextStyle(
            color: Colors.green,
            fontFamily: 'Poppins',
            fontSize: 50,
            
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(100, 25, 100, 2),
          child: TextField(
            style: TextStyle(
              color: Colors.white70,
            ),
            decoration: InputDecoration(
              hintText: 'Full Name',
              hintStyle: TextStyle(
                color: Colors.white60,
                fontFamily: 'Poppins',
              ),
              border: OutlineInputBorder(),
            ),
          ),
        ),

        Padding(
            padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
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
            padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
            child: TextField(
              style: TextStyle(
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                hintText: 'Phone Number',
                hintStyle: TextStyle(
                  color: Colors.white60,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
            child: TextField(
              style: TextStyle(
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                hintText: 'Full Name',
                hintStyle: TextStyle(
                  color: Colors.white60,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
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
            padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
            child: TextField(
              style: TextStyle(
                color: Colors.white70,
              ),
              decoration: InputDecoration(
                hintText: 'Repeat Password',
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Already got an account?',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => loginPage(),
                  ));
                  },
                  child: Text('Login here!'),
                ),
              ]
            ),
          ),
         

          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => licenceRequest(),
            ));
              },
              child: Text('Submit!'),
            ),
          )

        ],
      )

    );
  }
}