import 'package:flutter/material.dart';
import 'package:get_a_lift/publishTrip.dart';
import 'package:get_a_lift/report.dart';
import 'package:get_a_lift/searchTrip.dart';

import 'ProfilePage.dart';

class HomePagePassenger extends StatefulWidget {
  const HomePagePassenger({super.key});

  @override
  State<HomePagePassenger> createState() => homePagePassenger();
}

class homePagePassenger extends State<HomePagePassenger> {
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("HomePage"),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ));
          },
        ),
      ),

      body: Column(
        children: [
          TextButton(
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
          TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReportPage()
                    ));
            },
            child: Text(
              'Report an Incident',
              style: TextStyle(
                fontFamily: 'Poppins',
              )
            ),
          ),
        ],
      ),
    );
  }
}

