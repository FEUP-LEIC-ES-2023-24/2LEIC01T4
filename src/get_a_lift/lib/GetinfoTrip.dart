import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetinfoTrip extends StatelessWidget {
  final String documentId;

  GetinfoTrip({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference trips = FirebaseFirestore.instance.collection('trips');

    return FutureBuilder<DocumentSnapshot>(
      future: trips.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Text('${data['departure']} >> ${data['destination']}');
        }
        return Text('loading..');
      }),

    );
  }
}