import 'package:flutter/material.dart';
import 'package:get_a_lift/publishTrip.dart';
import 'package:get_a_lift/searchTrip.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => homePage();
}

class homePage extends State<HomePage> {
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
                builder: (context) => SearchTrip(),
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
                builder: (context) => PublishTrip(),
          ));
        },
      ),
    );
  }
}

