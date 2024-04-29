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
  CollectionReference trips = FirebaseFirestore.instance.collection('trips');


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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
                        suggestionsCallback: (pattern) async {
                          final districts = FirebaseFirestore.instance.collection('districts');
                          final snapshot = await districts.where('nome', isGreaterThanOrEqualTo: pattern).get();
                          return snapshot.docs.map((doc) => doc['nome']).toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          // Handle when a suggestion is selected.
                          _departureController.text = suggestion;
                          print('Selected departure city: $suggestion');
                          // Trigger the state update to reflect the filtered list
                          setState(() {});
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
                            hintText: 'Destination city...',
                          ),
                        ),
                        suggestionsCallback: (pattern) async {
                          final districts = FirebaseFirestore.instance.collection('districts');
                          final snapshot = await districts.where('nome', isGreaterThanOrEqualTo: pattern).get();
                          return snapshot.docs.map((doc) => doc['nome']).toList();
                        },
                        itemBuilder: (context, suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        onSuggestionSelected: (suggestion) {
                          // Handle when a suggestion is selected.
                          _destinationController.text = suggestion;
                          print('Selected destination city: $suggestion');
                          // Trigger the state update to reflect the filtered list
                          setState(() {});
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Show loading indicator while fetching data
                    } else {
                      // Create a set to store unique trip IDs
                      Set<String> uniqueTripIds = Set<String>();
                      return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<DocumentSnapshot>(
                            future: trips.doc(docIDs[index]).get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                String departureCity = data['departure'];
                                String destinationCity = data['destination'];
                                String tripId = docIDs[index];
                                // Check if the trip matches the selected criteria and if it's not already added to the set
                                bool matchesDeparture = departureCity.toLowerCase().contains(_departureController.text.toLowerCase()) || _departureController.text.isEmpty;
                                bool matchesDestination = destinationCity.toLowerCase().contains(_destinationController.text.toLowerCase()) || _destinationController.text.isEmpty;
                                if (matchesDeparture && matchesDestination && !uniqueTripIds.contains(tripId)) {
                                  // Add the trip ID to the set
                                  uniqueTripIds.add(tripId);
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigate to a new page or show more details when the item is clicked
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DetailsTrip(documentId: tripId),
                                        ),
                                      );
                                    },
                                    child: ListTile(
                                      title: Text('$departureCity >> $destinationCity'),
                                    ),
                                  );
                                } else {
                                  // If the trip does not match the selected criteria or it's already added, don't display it
                                  return SizedBox.shrink();
                                }
                              } else {
                                // Show loading indicator while fetching data for this trip
                                return SizedBox(
                                  height: 24.0,
                                  width: 24.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.0,
                                  ),
                                );
                              }
                            },
                          );
                        },
                      );
                    }
                  },
                ),
              ),

            ],
          ),
        ),

      ),
    );
  }
}

