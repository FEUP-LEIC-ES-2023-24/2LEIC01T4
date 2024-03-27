import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: MakeTrip(),
));

class MakeTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text(
          'Search Your Trip',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins'
            ),
          ),
          centerTitle: true,    
      ),

      
      body: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Image.asset(
              "assets/img2.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
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