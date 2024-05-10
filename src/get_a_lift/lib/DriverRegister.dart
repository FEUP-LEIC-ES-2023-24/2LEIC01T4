import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_a_lift/homePage.dart';

import 'firebase_auth_implementation/firebase_auth_services.dart';
import 'notifications/toast.dart';

class DriverRegisterPage extends StatefulWidget {
  const DriverRegisterPage({super.key});

  @override
  State<DriverRegisterPage> createState() => _DriverRegisterState();
}

class _DriverRegisterState extends State<DriverRegisterPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  Uint8List? _image;

  Future<void> selectImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = await pickedFile.readAsBytes();
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: Text(
          'Add drivers license',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins'
          ),
        ),
        centerTitle: true,
      ),
      body:
      Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              "assets/gradient.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            top: 5,
            left: MediaQuery.of(context).size.width / 2 - 311 / 2, // Calculate the left position to center the image horizontally
            child: Container(
              width: 311, // Set the width of the container
              child: Opacity(
                opacity: 1,
                child: Image.asset(
                  "assets/logoS.png",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 160),
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                        radius: 24,
                      )
                          :const CircleAvatar(
                        radius: 24,
                      ),
                      Positioned(
                        bottom:0,
                        left: 0,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextButton(
                    onPressed: () {
                      _addLicense();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _addLicense() async {
    if (_image == null) {
      showToast(message: "Please upload driver license!");
    } else {
      try {
        // Get the email of the current authenticated user
        String? email = FirebaseAuth.instance.currentUser?.email;

        // Check if email is available
        if (email != null) {
          // Fetch the document ID of the user document in Firestore using the email
          QuerySnapshot<Object?> snapshot = await users.where('email', isEqualTo: email).limit(1).get();

          // Check if user document exists
          if (snapshot.docs.isNotEmpty) {
            String userId = snapshot.docs.first.id;

            // Upload driver's license to Firestore
            DocumentReference licenseRef = await FirebaseFirestore.instance.collection('license').add({
              'userId': userId,
              'image': _image,
            });

            // Update user's permission to "driver"
            await users.doc(userId).update({
              'permission': 'driver',
              'licenseId': licenseRef.id, // Store license ID for reference
            });

            showToast(message: "Driver License submitted successfully!");
            Navigator.pushNamed(context, "/home");
          } else {
            showToast(message: "User document not found!");
          }
        } else {
          showToast(message: "Email not found!");
        }
      } catch (e) {
        print("Error submitting driver's license: $e");
        showToast(message: "Failed to submit driver license. Please try again later.");
      }
    }
  }

}

