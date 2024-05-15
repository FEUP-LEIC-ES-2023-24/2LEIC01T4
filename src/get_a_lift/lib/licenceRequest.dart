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

      body:Stack(
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
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DriverRegisterPage(),
              ));
            },
            child: Text(
                'Register As Driver',
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
          SizedBox(height: 30), // Add a space between the buttons
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomePagePassenger(),
              ));
            },
            child: Text(
                'Continue As Passenger',
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
        ],
      )
    ],
    ),
    );
  }
}