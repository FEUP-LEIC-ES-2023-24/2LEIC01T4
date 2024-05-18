import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_a_lift/notifications/toast.dart';
import 'package:get_a_lift/registerPage.dart';
import 'package:get_a_lift/homePage.dart';
import 'package:get_a_lift/widgets/form_container_widget.dart';

import 'changePasswordPage.dart';
import 'firebase_auth_implementation/firebase_auth_services.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});



  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  bool passwordVisible = false;
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
      body: Stack(
        children: [
          // Background image
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              "assets/gradient.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
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
                      color: Colors.white70,
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
                  obscureText: passwordVisible,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: Colors.white70,
                      fontFamily: 'Poppins',
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      },
                    ),
                    alignLabelWithHint: false,
                    filled: false,
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) {
                                  return changePasswordPage();
                                }
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    )
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                              (route) => false,
                        );
                      },
                      child: Text('Sign up here!',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 20, 8.0, 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: Text('Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 15,
                    ),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                      shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                      elevation: MaterialStateProperty.resolveWith<double>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) return 10;
                          return 5; // default elevation
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      animationDuration: Duration(milliseconds: 200)
                  ),
                ),
              )

            ],
          )
        ],
      ),
    );
  }

  void _login() async{
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.loginWithEmailAndPassword(email, password);

    if (user != null) {
      showToast(message: "User is successfully signed in");
      if(await _getPublisherPermission(email)){
        Navigator.pushNamed(context, "/home");
      } else{
        Navigator.pushNamed(context, "/homePassenger");
      }
    } else {
      showToast(message: "some error occurred");
    }
  }

  Future<bool> _getPublisherPermission(String email) async {
    try {
      // Fetch user's permission from the database using email
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      String permission;
      // Check if any document matches the email
      if (snapshot.docs.isNotEmpty) {
        // Return the permission from the first document found
        permission = snapshot.docs.first.get('permission');
      } else {
        // If no document matches the email, consider it as a passenger
        permission = 'passenger';
      }
      // Check permission and return accordingly
      if (permission == 'driver') {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // Handle exceptions here
      print('Error fetching permission: $e');
      return false; // Or handle differently based on your use case
    }
  }
}