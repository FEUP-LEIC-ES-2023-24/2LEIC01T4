import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_a_lift/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:get_a_lift/licenceRequest.dart';
import 'package:get_a_lift/loginPage.dart';
import 'package:get_a_lift/notifications/toast.dart';
import 'package:get_a_lift/widgets/form_container_widget.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
            controller: _usernameController,
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
            padding: const EdgeInsets.fromLTRB(100, 2, 100, 2),
            child: TextField(
              controller: _phoneController,
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
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginPage()),
                            (route) => false);
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
                _register();
              },
              child: Text('Submit!'),
            ),
          )

        ],
      )

    );
  }

  void _register() async{
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String phonenumber = _phoneController.text;

    User? user = await _auth.registerWithEmailAndPassword(email, password);

    if (user != null) {
      addUserDetails(username, email, int.parse(phonenumber));
      showToast(message: "User is successfully created");
      Navigator.pushNamed(context, "/licenceRequest");
    } else {
      showToast(message: "Some error happend");
    }
  }

  Future addUserDetails(String username, String email, int phone) async{
    await FirebaseFirestore.instance.collection('users').add({
      'username': username,
      'email': email,
      'phone number': phone,
    });
  }
}