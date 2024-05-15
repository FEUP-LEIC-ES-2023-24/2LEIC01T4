import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_a_lift/ChatBubble.dart';
import 'package:get_a_lift/message.dart';

class ContactDriverPage extends StatefulWidget {
  final String documentId;

  ContactDriverPage({required this.documentId});

  @override
  _ContactDriverPageState createState() => _ContactDriverPageState();
}

class _ContactDriverPageState extends State<ContactDriverPage> {
  late TextEditingController _messageController;
  final CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? receiverID;
  String? receiverUsername;
  String? receiverEmail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final snapshot = await users.doc(widget.documentId).get();
      if (snapshot.exists) {
        setState(() {
          receiverID = snapshot.get('uid');
          receiverUsername = snapshot.get('username');
          receiverEmail = snapshot.get('email');
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching user data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _sendMessage(receiverID!, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isLoading ? Text('Loading...') : Text(receiverUsername ?? 'Driver'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = auth.currentUser!.uid;
    return StreamBuilder(
      stream: _getMessage(receiverID!, senderID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading..");
        }
        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderID'] == auth.currentUser!.uid;
    var alignments = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignments,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
          ],
        ),
    );
  }

  Widget _buildUserInput() {
    return Container(
      color: Colors.grey[200], // Set the background color to grey
      padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0), // Add padding to the bottom
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              obscureText: false,
              decoration: InputDecoration(
                border: InputBorder.none, // Remove the border
                hintText: 'Type your message here...', // Add a hint text
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: Icon(Icons.arrow_upward),
          ),
        ],
      ),
    );
  }



  Future<void> _sendMessage(String receiverID, message) async {
    final String currentUserID = auth.currentUser!.uid;
    final String currentUserEMAIL = auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderID: currentUserID,
      senderEmail: currentUserEMAIL,
      receiverID: receiverID,
      message: message,
      timestamp: timestamp,
    );

    try {
      List<String> ids = [currentUserID, receiverID];
      ids.sort();
      String chatRoomID = ids.join('_');

      // Check if the chat room exists, if not, create it
      final chatRoomRef = FirebaseFirestore.instance.collection("chat_rooms").doc(chatRoomID);
      if (!(await chatRoomRef.get()).exists) {
        await chatRoomRef.set({});
      }

      // Add the message to the chat room
      await chatRoomRef.collection("messages").add(newMessage.toMap());
    } catch (e) {
      print('Error sending message: $e');
      // Handle error here
    }
  }


  Stream<QuerySnapshot> _getMessage(String userID, otherUserID) {
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return FirebaseFirestore.instance.collection("chat_rooms").doc(chatRoomID).collection("messages").orderBy("timestamp", descending: false).snapshots();
  }
}
