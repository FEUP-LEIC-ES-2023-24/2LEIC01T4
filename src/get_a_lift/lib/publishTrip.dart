import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/notifications/toast.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'firebase_auth_implementation/firebase_auth_services.dart';


class PublishTrip extends StatefulWidget {
  const PublishTrip({super.key});

  @override
  State<PublishTrip> createState() => PublishTripState();
}

class PublishTripState extends State<PublishTrip> {

  final FirebaseAuthService _auth = FirebaseAuthService();
  final user = FirebaseAuth.instance.currentUser;

  TextEditingController _departureController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();
  TextEditingController _petfriendlyController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    _petfriendlyController.dispose();
    _priceController.dispose();
    _numberController.dispose();
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
          'Publish Your Trip',
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins'
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
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
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _departureController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: 'Departure',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.green.shade300,
                                width: 2
                            )
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _destinationController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: 'Destination',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.green.shade300,
                                width: 2
                            )
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _priceController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: 'Price',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.green.shade300,
                                width: 2
                            )
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _numberController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: 'Number Of Persons',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.green.shade300,
                                width: 2
                            )
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text('Pet-Friendly',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ToggleSwitch(
                        activeBgColors: [[Colors.green], [Colors.redAccent]],
                        activeFgColor: Colors.white,
                        initialLabelIndex: 0,
                        totalSwitches: 2,
                        labels: [
                          'Yes',
                          'No',
                        ],
                        onToggle: (index) {
                          _petfriendlyController.text = index == 0 ? 'Yes' : 'No';
                          print('switched to: $index');
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _descriptionController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                        hintText: 'Description (optional)',
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Poppins',
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.green.shade300,
                                width: 2
                            )
                        )
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text(
                    'Select Date',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: () {
                        _publish();
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey.shade800)
                      )
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }




  void _publish() async {
    String departure = _departureController.text;
    String destination = _destinationController.text;
    String petfriendly = _petfriendlyController.text;
    String price = _priceController.text;
    String number = _numberController.text;
    String description = _descriptionController.text;

    String? userEmail = user?.email; // Get current user's email
    String uid = user!.uid;
    String publisher = await _getPublisherName(userEmail!) ?? "Unknown";
    double minimumRating = await _getMinRating(uid) ?? 0.0;

    addTripDetails(departure, destination, petfriendly, double.parse(price), int.parse(number), description, publisher, minimumRating);
    showToast(message: "Trip has been posted");
    Navigator.pushNamed(context, "/home");
  }

  Future<String?> _getPublisherName(String email) async {
    try {
      // Fetch user's username from database using email
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      // Check if any document matches the email
      if (snapshot.docs.isNotEmpty) {
        // Return the username from the first document found
        return snapshot.docs.first.get('username');
      } else {
        // Return null if no matching document found
        return null;
      }
    } catch (e) {
      // Handle any potential errors
      print('Error fetching username: $e');
      return null;
    }
  }

  Future<double?> _getMinRating(String uid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('driver_preferences')
          .where('userId', isEqualTo: uid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        var minRating = snapshot.docs.first.get('minimumRating');
        if (minRating is int) {
          return minRating.toDouble();
        } else if (minRating is double) {
          return minRating;
        } else {
          // Handle unexpected type if necessary
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching minimumRating: $e');
      return null;
    }
  }



  Future addTripDetails(String departure, String destination, String petfriendly, double price, int number, String description, String publisher, double minimumRating) async{
    await FirebaseFirestore.instance.collection('trips').add({
      'departure': departure,
      'destination': destination,
      'petfriendly': petfriendly,
      'price': price,
      'number of passengers': number,
      'description': description,
      'publisher': publisher,
      'minimumRating': minimumRating,
      'date': _selectedDate, // Add selected date to the data
    });
  }

}