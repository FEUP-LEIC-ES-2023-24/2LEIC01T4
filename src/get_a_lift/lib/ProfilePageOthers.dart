import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_a_lift/Details.dart';
import 'package:get_a_lift/ProfileInfoTrip.dart';
import 'package:get_a_lift/ProfileReviews.dart';
import 'package:get_a_lift/contact_driver_page.dart';

void main() => runApp(MaterialApp(
  home: ProfilePageOthers(username: "example_username"),
));

class ProfilePageOthers extends StatefulWidget {
  final String username;

  const ProfilePageOthers({required this.username});

  @override
  _ProfilePageOthersState createState() => _ProfilePageOthersState();
}

class _ProfilePageOthersState extends State<ProfilePageOthers> {
  late String username;
  String? rating;
  List<String> docIDs = [];
  List<String> reviewsIDs = [];

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    super.initState();
    username = widget.username;
    getRating();
  }

  Future<void> getRating() async {
    try {
      final snapshot = await _getUserData(username);
      if (snapshot != null) {
        setState(() {
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

  Future<Map<String, dynamic>?> _getUserData(String username) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
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
          'Profile: $username',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'Rating: ${_getRoundedRating()} ⭐',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Trips:',
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
                    child: ListTile(
                      title: ProfileInfoTrip(documentId: docIDs[index]),
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
                  return ListTile(
                    title: ProfileReviews(documentId: reviewsIDs[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            QuerySnapshot userQuery = await users.where('username', isEqualTo: username).get();
            if (userQuery.docs.isNotEmpty) {
              String userId = userQuery.docs.first.id;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDriverPage(documentId: userId),
                ),
              );
            } else {
              print('User not found with username: $username');
            }
          },
          child: Text('Contact $username'),
        ),
      ),
    );
  }
}

