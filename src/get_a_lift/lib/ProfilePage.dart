import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/Details.dart';
import 'package:get_a_lift/GetinfoTrip.dart';
import 'package:get_a_lift/ProfileInfoTrip.dart';

void main() => runApp(MaterialApp(
  home: ProfilePage(),
));

class ProfilePage extends StatelessWidget {
  // Dummy trip data (replace this with actual data retrieval logic)
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('trips').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
          print(document.reference);
          docIDs.add(document.reference.id);
        },
      ),
    );
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
            Text(
              'Username: JohnDoe', // Replace with dynamic username retrieval
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
              child: FutureBuilder(
                future: getDocId(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: docIDs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigate to a new page or show more details when the item is clicked
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
