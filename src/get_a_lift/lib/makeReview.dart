import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_a_lift/homePage.dart';

import 'firebase_auth_implementation/firebase_auth_services.dart';
import 'notifications/toast.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  final user = FirebaseAuth.instance.currentUser;

  double rating = 0;
  TextEditingController _driverController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();


  @override
  void dispose() {
    _driverController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: Text(
          'Write a Review',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      this.rating = rating;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _driverController,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins'
                    ),
                    decoration: InputDecoration(
                        hintText: 'Enter the name of the driver you are reviewing',
                        hintStyle: TextStyle(
                            color: Colors.white70,
                            fontFamily: 'Poppins'
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.green.shade300,
                                width: 2
                            )
                        )
                    ),
                    minLines: 2,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: _descriptionController,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins'
                      ),
                      decoration: InputDecoration(
                          hintText: 'Comment on your experience with the driver',
                          hintStyle: TextStyle(
                              color: Colors.white70,
                              fontFamily: 'Poppins'
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.green.shade300,
                                  width: 2
                              )
                          )
                      ),
                      maxLines: 5,
                      minLines: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      _review();
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

  void _review() async {
    if (_driverController.text.isEmpty || _descriptionController.text.isEmpty) {
      showToast(message: "Please fill in all fields!");
      return;
    }

    final currentUserEmail = _auth.getCurrentUser().email;

    // Add the review to the reviews collection
    final userQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: currentUserEmail)
        .get();

    if (userQuery.docs.isNotEmpty) {
      final userData = userQuery.docs.first.data();
      final userID = userQuery.docs.first.id;

      await FirebaseFirestore.instance.collection('reviews').add({
        'driverName': _driverController.text,
        'description': _descriptionController.text,
        'rating': rating,
        'userID': userID,
      });
    }

    // Update the user's profile
    final driverQuery = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: _driverController.text)
        .get();

    if (driverQuery.docs.isNotEmpty) {
      final userData = driverQuery.docs.first.data();
      final numberOfReviews = userData['number of reviews'] ?? 0;
      final oldRating = userData['rating'] ?? 0.0;

      final newNumberOfReviews = numberOfReviews + 1;
      final newRating = (oldRating * numberOfReviews + rating) / newNumberOfReviews;

      // Update user's data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(driverQuery.docs.first.id)
          .update({
        'number of reviews': newNumberOfReviews,
        'rating': newRating,
      });

      showToast(message: "Review submitted successfully");

      if (user != null) {
        bool isDriver = await _getPublisherPermission(user!.email!);
        if (isDriver) {
          Navigator.pushNamed(context, "/home");
        } else {
          Navigator.pushNamed(context, "/homePassenger");
        }
      }
    } else {
      showToast(message: "Driver not found!");
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