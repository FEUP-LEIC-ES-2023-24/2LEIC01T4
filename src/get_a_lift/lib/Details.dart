import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_a_lift/contact_driver_page.dart'; // Import FirebaseAuth if you're using Firebase Authentication

class DetailsTrip extends StatelessWidget {
  final String documentId;

  DetailsTrip({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference trips = FirebaseFirestore.instance.collection('trips');
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Details"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: trips.doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            String publisherUsername = data['publisher'];

            return ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                ListTile(
                  title: Text('Departure'),
                  subtitle: Text(data['departure']),
                ),
                ListTile(
                  title: Text('Destination'),
                  subtitle: Text(data['destination']),
                ),
                ListTile(
                  title: Text('Number of Passengers'),
                  subtitle: Text(data['number of passengers'].toString()),
                ),
                ListTile(
                  title: Text('Pet Friendly'),
                  subtitle: Text(_getPetFriendlyStatus(data['petfriendly'])),
                ),
                ListTile(
                  title: Text('Price'),
                  subtitle: Text(data['price'].toString()),
                ),
                ListTile(
                  title: Text('Description'),
                  subtitle: Text(data['description']),
                ),
                ListTile(
                  title: Text('Publisher'),
                  subtitle: Text(publisherUsername),
                ),
                ElevatedButton(
                  onPressed: () async {
                    QuerySnapshot userQuery = await users.where('username', isEqualTo: publisherUsername).get();
                    if (userQuery.docs.isNotEmpty) {
                      String userId = userQuery.docs.first.id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactDriverPage(documentId: userId),
                        ),
                      );
                    } else {
                      print('User not found with username: $publisherUsername');
                    }
                  },
                  child: Text('Contact $publisherUsername'),
                ),
              ],
            );
          } else {
            return Text('No data');
          }
        },
      ),
    );
  }

  String _getPetFriendlyStatus(dynamic petfriendlyData) {
    if (petfriendlyData == null) {
      return 'Yes'; // Treat null as Yes
    } else if (petfriendlyData is bool) {
      return petfriendlyData ? 'Yes' : 'No';
    } else if (petfriendlyData is String) {
      return 'Yes'; // Treat non-boolean strings as Yes
    } else {
      return 'Unknown'; // Handle other unexpected data types
    }
  }
}

