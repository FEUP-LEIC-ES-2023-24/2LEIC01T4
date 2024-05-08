import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_a_lift/DriverRegister.dart';
import 'package:get_a_lift/homePage.dart';
import 'package:get_a_lift/homePagePassenger.dart';


class LicenceRequest extends StatefulWidget {
  const LicenceRequest({super.key});

  @override
  State<LicenceRequest> createState() => licenceRequest();
}

class licenceRequest extends State<LicenceRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade800,

      body: Stack(
        children: [
          Opacity(
            opacity: 0.6,
            child: Image.asset(
              "assets/licenceRequest.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 100, 10, 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DriverRegisterPage(),
                ));
              },
              child: Text(
                'Register As Driver',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
              ),
              
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(300, 100, 5, 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePagePassenger(),
                ));
              },
              child: Text(
                'Continue As Passenger',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey.shade800),
              ),
            ),
          ),

        ],
      )
    );
  }
}