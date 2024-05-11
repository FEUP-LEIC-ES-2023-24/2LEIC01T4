import 'package:flutter/material.dart';
import 'package:get_a_lift/publishTrip.dart';
import 'package:get_a_lift/report.dart';
import 'package:get_a_lift/searchTrip.dart';


import 'ProfilePage.dart';
import 'makeReview.dart';

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
      body:
      Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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

