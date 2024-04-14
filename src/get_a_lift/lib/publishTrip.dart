import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

void main() => runApp(MaterialApp(
  home: publishTrip(),
));

class publishTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text(
          'Publish Your Trip',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins'
            ),
          ),
          centerTitle: true,    
      ),
      
      body: 
      Stack(
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.asset(
              "assets/gradient.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          
    Positioned(
      top: 5,
      left: MediaQuery.of(context).size.width / 2 - 311 / 2, // Calculate the left position to center the image horizontally
      child: Container(
        width: 311, // Set the width of the container
        child: Opacity(
          opacity: 1,
          child: Image.asset(
            "assets/logoS.png",
          ),
        ),
      ),
    ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Departure',
                      hintStyle: TextStyle(
                        color: Colors.white60,
                        fontFamily: 'Poppins',
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Destination',
                      hintStyle: TextStyle(
                        color: Colors.white60,
                        fontFamily: 'Poppins',
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Price',
                      hintStyle: TextStyle(
                        color: Colors.white60,
                        fontFamily: 'Poppins',
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Number Of Persons',
                      hintStyle: TextStyle(
                        color: Colors.white60,
                        fontFamily: 'Poppins',
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text('Pet-Friendly',
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ToggleSwitch(
                        activeBgColors: [[Colors.green], [Colors.redAccent]],
                        activeFgColor: Colors.white,
                        initialLabelIndex: 0,
                        totalSwitches: 2,
                        labels: [
                          'Yes',
                          'No',
                        ],
                        onToggle: (index) {
                          print('switched to: $index');
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Description (optional)',
                      hintStyle: TextStyle(
                        color: Colors.white60,
                        fontFamily: 'Poppins',
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Poppins',
                        ),
                      ),

                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey.shade800)
                      )
                    
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}