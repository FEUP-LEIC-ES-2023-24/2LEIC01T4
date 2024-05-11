import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/notifications/toast.dart';
import 'changePasswordPage.dart';

class changePasswordPage extends StatefulWidget {
  const changePasswordPage({super.key});

  @override
  State<changePasswordPage> createState() => _changePasswordPageState();
}

class _changePasswordPageState extends State<changePasswordPage> {

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<bool> isEmailRegisteredInDatabase(String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();

    return snapshot.docs.isNotEmpty;
  }

  Future passwordReset() async {
    String email = _emailController.text.trim();

    if(email.isEmpty){
      showToast(message: "Please enter your email");
      return;
    }

    try {
      bool isEmailRegistered = await isEmailRegisteredInDatabase(email);
      if(isEmailRegistered){
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        showToast(message: "Check your email inbox for the password change list!");
      }
      else {
        showToast(message: "This email is not being used by any user!");
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showToast(message: e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'Change Your Password',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              'Enter your email for us to send an email!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: TextField(
              controller: _emailController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Poppins',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          MaterialButton(
            onPressed: passwordReset,
            child: Text(
              'Reset Password',
            ),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
