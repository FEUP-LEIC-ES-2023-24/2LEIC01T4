import 'package:flutter/material.dart';
import 'package:get_a_lift/Contacts.dart';
import 'package:get_a_lift/publishTrip.dart';
import 'package:get_a_lift/report.dart';
import 'package:get_a_lift/searchTrip.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'ProfilePage.dart';
import 'makeReview.dart';

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
      backgroundColor: Colors.grey.shade800,
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

      body: Stack(
        children: [
        // Background image
        Opacity(
        opacity: 0.7,
        child: Image.asset(
          "assets/gradient.jpg",
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
      Column (
        children: [
          SizedBox(height:20),
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              child: AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'Welcome to Get a Lift!',
                    textStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
                isRepeatingAnimation: false,
              ),
            ),
          ),
          SizedBox(height: 140),
          Center(
            child:
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SearchTrip(),
                ));
              },
              child: Text(
                  'Search Your Trip',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 25,
                    color: Colors.white,
                  )
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                  elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) return 10;
                      return 5; // default elevation
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  animationDuration: Duration(milliseconds: 200)
              ),
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReportPage()
              ));
            },
            child: Text(
                'Report an Incident',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 25,
                  color: Colors.white,
                )
            ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) return 10;
                    return 5; // default elevation
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                animationDuration: Duration(milliseconds: 200)
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          ElevatedButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReviewPage(),
            ));
          }, child: Text(
            'Make a Review',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 25,
              color: Colors.white,
            ),
          ),
            style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shadowColor: MaterialStateProperty.all<Color>(Colors.grey),
                elevation: MaterialStateProperty.resolveWith<double>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) return 10;
                    return 5; // default elevation
                  },
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                animationDuration: Duration(milliseconds: 200)
            ),
          ),
        ],
      ),
      ],
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 16.0,
            left: 36.0,
            child: FloatingActionButton(
              onPressed: () {
                // Navigate to MessageListPage when the button is pressed
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MessageListPage(),
                ));
              },
              child: Icon(Icons.message),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
