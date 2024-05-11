import 'dart:typed_data';
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
                    decoration: InputDecoration(
                        hintText: 'Enter the name of the driver you are reviewing',
                        hintStyle: TextStyle(
                            color: Colors.white,
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
                      decoration: InputDecoration(
                          hintText: 'Comment on your experience with the driver',
                          hintStyle: TextStyle(
                              color: Colors.white,
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

  void _review() async{
    if (_driverController.text.isEmpty || _descriptionController.text.isEmpty) {
      showToast(message: "Please fill in all fields!");
      return;
    }

    await FirebaseFirestore.instance.collection('reviews').add({
      'driverName': _driverController.text,
      'description': _descriptionController.text,
      'rating': rating,
      'userID': _auth.getCurrentUser().uid,
    });

    showToast(message: "Review submitted successfully");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

}

