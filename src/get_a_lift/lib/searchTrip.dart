import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/Details.dart';
import 'package:get_a_lift/GetInfoTrip.dart';


class SearchTrip extends StatefulWidget {
  const SearchTrip({super.key});

  @override
  State<SearchTrip> createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  final user = FirebaseAuth.instance.currentUser!;

  List<String> cities = [];
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


  Future<void> getCitiesDocId() async {
    final districts = FirebaseFirestore.instance.collection('districts');
    final snapshot = await districts.get();
    for (final document in snapshot.docs) {
      final data = document.data() as Map<String, dynamic>;
      cities.add(data['nome']);
    }
    setState(() {}); // Update the state
  }

  @override
  void initState() {
    super.initState();
    getCitiesDocId(); // Call getCitiesDocId when the widget is initialized
  }

  final _departureController = TextEditingController();
  final _destinationController = TextEditingController();

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
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          controller: _departureController,
                          decoration: const InputDecoration(
                            hintText: 'Departure city...',
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return cities
                              .where((country) => country.toLowerCase().contains(pattern.toLowerCase()))
                              .toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          // Handle when a suggestion is selected.
                          _departureController.text = suggestion;
                          print('Selected city: $suggestion');
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TypeAheadField(
                        textFieldConfiguration: TextFieldConfiguration(
                          autofocus: true,
                          controller: _destinationController,
                          decoration: const InputDecoration(
                            hintText: 'Departure city...',
                          ),
                        ),
                        suggestionsCallback: (pattern) {
                          return cities
                              .where((country) => country.toLowerCase().contains(pattern.toLowerCase()))
                              .toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          // Handle when a suggestion is selected.
                          _destinationController.text = suggestion;
                          print('Selected city: $suggestion');
                        },
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