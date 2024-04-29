import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ContactDriverPage extends StatefulWidget {
  final String documentId;

  ContactDriverPage({required this.documentId});

  @override
  _ContactDriverPageState createState() => _ContactDriverPageState();
}

class _ContactDriverPageState extends State<ContactDriverPage> {
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users'); // Changed collection reference to 'users'
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(), // Fetching user document based on user ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Text('Contact ${data['username']}'),
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade200, Color.fromARGB(255, 158, 83, 165)],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Contact ${data['username']} via phone number:',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Implement logic to initiate a call to the driver's phone number
                        print('Calling ${data['username']} at ${data['phone number']}...');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                      ),
                      child: Text(
                        'Call ${data['username']}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter your message...',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color.fromARGB(0, 243, 243, 243),
                        contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      ),
                      maxLines: null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        String message = _messageController.text;
                        // Implement logic to send the message to the driver
                        print('Sending message to ${data['username']}: $message');
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                      ),
                      child: Text(
                        'Send message',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return SizedBox(); // Placeholder for other states
      },
    );
  }
}


