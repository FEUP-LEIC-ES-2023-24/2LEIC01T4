import 'package:flutter/material.dart';
import 'package:get_a_lift/publishTrip.dart';
import 'package:get_a_lift/searchTrip.dart';

void main() => runApp(MaterialApp(
  home: homePage(),
));

class homePage extends StatelessWidget {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("HomePage"),
        backgroundColor: Colors.green,
      ),

      body: TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => searchTrip(),
                ));
        },
        child: Text(
          'Search Your Trip',
          style: TextStyle(
            fontFamily: 'Poppins',
          )
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigation),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => publishTrip(),
          ));
        },
      ),
    );
  }
}