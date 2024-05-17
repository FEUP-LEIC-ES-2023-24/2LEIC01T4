import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/Details.dart';
import 'package:get_a_lift/GetinfoTrip.dart';
import 'package:get_a_lift/ProfileInfoTrip.dart';
import 'package:get_a_lift/ProfileReviews.dart';
import 'package:get_a_lift/changePasswordPage.dart';
import 'package:get_a_lift/licenceRequest.dart';
import 'package:get_a_lift/preferences_screen.dart';

void main() => runApp(MaterialApp(
  home: ProfilePage(),
));

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? user;
  String? username;
  String? permission;
  String? rating;
  List<String> docIDs = [];
  List<String> reviewsIDs = [];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    getUsername();
  }

  Future<void> getUsername() async {
    if (user != null) {
      String? email = user!.email;
      if (email != null) {
        try {
          final snapshot = await _getUserData(email);
          if (snapshot != null) {
            setState(() {
              username = snapshot['username'];
              permission = snapshot['permission'];
              rating = snapshot['rating'].toString();
            });
            if (username != null) {
              getTrips();
              getReviews();
            }
          }
        } catch (e) {
          print('Error fetching user data: $e');
        }
      }
    }
  }

  Future<Map<String, dynamic>?> _getUserData(String email) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.data();
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }

  Future<void> getTrips() async {
    if (username != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('trips')
          .where('publisher', isEqualTo: username)
          .get();

      setState(() {
        docIDs = snapshot.docs.map((doc) => doc.id).toList();
      });
    }
  }

  Future<void> getReviews() async {
    if (username != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance
          .collection('reviews')
          .where('driverName', isEqualTo: username)
          .get();

      setState(() {
        reviewsIDs = snapshot.docs.map((doc) => doc.id).toList();
      });
    }
  }

  String _getRoundedRating() {
    if (rating != null) {
      double parsedRating = double.parse(rating!);
      return parsedRating.toStringAsFixed(1);
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16),
            if (username != null)
              Text(
                'Username: $username',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            SizedBox(height: 16),
            Text(
              'Your Rating: ${_getRoundedRating()} ⭐',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => changePasswordPage(),
                  ),
                );
              },
              child: Text(
                'Change Password',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
              ),
            ),

            if (permission == 'driver') ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PreferencesScreen()),
                  );
                },
                child: const Text('Preferences',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    )
              ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                ),
              ),
            ],
            if (permission == 'passenger') ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LicenceRequest(),
                    ),
                  );
                },
                child: Text(
                  "Add Driver's License",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 12,
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                ),
              ),
            ],
            ],
            ),
            SizedBox(height: 25),
            Text(
              'Your Trips:',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsTrip(documentId: docIDs[index]),
                        ),
                      );
                    },
                    child:
                    Card(child:
                      ListTile(
                      title: ProfileInfoTrip(documentId: docIDs[index]),
                    ),
                      color: Colors.green.shade50,
                      elevation: 5,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Reviews:',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reviewsIDs.length,
                itemBuilder: (context, index) {
                  return Card(child:
                  ListTile(
                    title: ProfileReviews(documentId: reviewsIDs[index]),
                  ),
                    color: Colors.green.shade50,
                    elevation: 5,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model class for Trip data
class Trip {
  final String departureCity;
  final String destinationCity;
  final String date;
  final String description;
  final String opinion;
  final String reports;

  Trip({
    required this.departureCity,
    required this.destinationCity,
    required this.date,
    required this.description,
    required this.opinion,
    required this.reports,
  });
}
