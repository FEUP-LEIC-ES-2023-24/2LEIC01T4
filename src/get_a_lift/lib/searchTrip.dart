import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: searchTrip(),
));
class searchTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trips',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Trips'),
          centerTitle: true,
        ),
        body: TripFilterPage(),
      ),
    );
  }
}

class TripFilterPage extends StatefulWidget {
  @override
  _TripFilterPageState createState() => _TripFilterPageState();
}

class _TripFilterPageState extends State<TripFilterPage> {
  late TextEditingController departureController;
  late TextEditingController destinationController;

  @override
  void initState() {
    super.initState();
    departureController = TextEditingController();
    destinationController = TextEditingController();
  }

  @override
  void dispose() {
    departureController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: TextField(
                  controller: departureController,
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
                  controller: destinationController,
                  decoration: InputDecoration(
                    labelText: 'Destination',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}