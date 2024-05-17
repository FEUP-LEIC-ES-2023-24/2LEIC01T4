import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/ProfilePageOthers.dart';
import 'package:get_a_lift/contact_driver_page.dart';

class MessageListPage extends StatefulWidget {
  @override
  MessageListPageState createState() => MessageListPageState();
}

class MessageListPageState extends State<MessageListPage> {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _isLoading = true;
  List<Map<String, dynamic>> contacts = [];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    final String currentUserID = auth.currentUser!.uid;

    try {
      // Fetch all chat rooms
      final chatRoomsSnapshot = await FirebaseFirestore.instance.collection("chat_rooms").get();
      print("Chat rooms found: ${chatRoomsSnapshot.docs.length}");

      Set<String> contactIDs = Set<String>();

      // For each chat room, fetch the messages
      for (var room in chatRoomsSnapshot.docs) {
        print("Processing chat room: ${room.id}");
        final messagesSnapshot = await room.reference.collection('messages').get();
        print("Messages found: ${messagesSnapshot.docs.length}");

        for (var message in messagesSnapshot.docs) {
          var data = message.data() as Map<String, dynamic>;
          if (data['senderID'] == currentUserID) {
            contactIDs.add(data['receiverID']);
          } else if (data['receiverID'] == currentUserID) {
            contactIDs.add(data['senderID']);
          }
        }
      }

      print("Contact IDs found: $contactIDs");

      // Fetch user details for each contact ID
      List<Map<String, dynamic>> contactList = [];
      for (var contactID in contactIDs) {
        var userSnapshot = await users.where('uid', isEqualTo: contactID).get();
        if (userSnapshot.docs.isNotEmpty) {
          var userData = userSnapshot.docs.first.data() as Map<String, dynamic>;
          contactList.add({
            'uid': contactID,
            'username': userData['username'],
            'email': userData['email'],
          });
        }
      }

      setState(() {
        contacts = contactList;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching contacts: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(child:
              ListTile(
              leading: Icon(Icons.account_circle, size: 40),
              title: Text(contact['username']),
              subtitle: Text(contact['email']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePageOthers(username: contact['username']),
                  ),
                );
            },
            ),
            color: Colors.green.shade50,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          );
        },
      ),
    );
  }
}