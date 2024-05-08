import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/Details.dart';
import 'package:get_a_lift/GetinfoTrip.dart';
import 'package:get_a_lift/ProfileInfoTrip.dart';

void main() => runApp(MaterialApp(
  home: ProfilePage(),
));

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? user;
  late String? username;
  List<String> docIDs = [];

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
        String? name = await _getUsername(email);
        setState(() {
          username = name;
        });
        getTrips();
      }
    }
  }

  Future<String?> _getUsername(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.first.get('username');
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }

  Future<void> getTrips() async {
    if (username != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('trips')
          .where('publisher', isEqualTo: username)
          .get();

      setState(() {
        docIDs = snapshot.docs.map((doc) => doc.id).toList();
      });
    }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                          builder: (context) => DetailsTrip(documentId: docIDs[index]),
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
