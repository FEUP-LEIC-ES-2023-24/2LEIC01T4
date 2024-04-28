import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_a_lift/homePage.dart';

import 'firebase_auth_implementation/firebase_auth_services.dart';
import 'notifications/toast.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {

  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _reasonController = TextEditingController();
  TextEditingController _driverController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  Uint8List? _image;

  Future<void> selectImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = await pickedFile.readAsBytes();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _driverController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: Text(
          'Report an Incident',
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
                    controller: _reasonController,
                    decoration: InputDecoration(
                        hintText: 'Enter the reason for the report',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins'
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.green.shade300,
                                width: 2
                            )
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _driverController,
                    decoration: InputDecoration(
                        hintText: 'Enter the name of the driver you are reporting',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins'
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Colors.green.shade300,
                                width: 2
                            )
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                          hintText: 'Description of the incident',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins'
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  color: Colors.green.shade300,
                                  width: 2
                              )
                          )
                      ),
                      maxLines: 5,
                      minLines: 1,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                        radius: 24,
                      )
                      :const CircleAvatar(
                        radius: 24,
                      ),
                      Positioned(
                        bottom:0,
                        left: 0,
                        child: IconButton(
                          onPressed: selectImage,
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      _report();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        )
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins'
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _report() async{
    String reason = _reasonController.text;
    String driver = _driverController.text;
    String description = _descriptionController.text;

    if(reason.isEmpty || driver.isEmpty || description.isEmpty){
      showToast(message: "Please fill in all fields!");
    } else {
      await FirebaseFirestore.instance.collection('reports').add({
        'reason': reason,
        'driver': driver,
        'description': description,
        'image': _image,
      });
      showToast(message: "Report submitted successfully!");
      Navigator.pushNamed(context, "/home");
    }
  }

}

