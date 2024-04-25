
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/Details.dart';
import 'package:get_a_lift/GetinfoTrip.dart';

class SearchTrip extends StatefulWidget {
  const SearchTrip({super.key});

  @override
  State<SearchTrip> createState() => searchTrip();
}

class searchTrip extends State<SearchTrip> {
  final user = FirebaseAuth.instance.currentUser!;

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

  TextEditingController _departureController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trips',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Trips'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextField(
                        controller: _departureController,
                        decoration: InputDecoration(
                          labelText: 'Departure',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextField(
                        controller: _destinationController,
                        decoration: InputDecoration(
                          labelText: 'Destination',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Spacer between the Row and Column
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
                          title: GetinfoTrip(documentId: docIDs[index]),
                        ),
                        );
                      },
                    );
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}


