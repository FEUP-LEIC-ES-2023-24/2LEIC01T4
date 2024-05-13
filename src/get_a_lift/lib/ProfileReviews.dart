import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileReviews extends StatelessWidget {
  final String documentId;

  ProfileReviews({required this.documentId});

  @override
  Widget build(BuildContext context) {
    CollectionReference reviews = FirebaseFirestore.instance.collection('reviews');
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: reviews.doc(documentId).get(),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? reviewData = snapshot.data!.data() as Map<String, dynamic>?;

          if (reviewData != null) {
            return FutureBuilder<DocumentSnapshot>(
              future: users.doc(reviewData['userID']).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic>? userData = userSnapshot.data!.data() as Map<String, dynamic>?;

                  if (userData != null) {
                    double rating = double.parse(reviewData['rating'].toString());
                    int fullStars = rating.floor();
                    bool hasHalfStar = rating - fullStars >= 0.5;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${userData['username']} ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: List.generate(fullStars, (index) => Icon(Icons.star, color: Colors.yellow)),
                            ),
                            if (hasHalfStar) Icon(Icons.star_half, color: Colors.yellow),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${reviewData['description']}',
                        ),
                      ],
                    );
                  } else {
                    return Text('User data not available'); // Show text when user data is not available
                  }
                } else {
                  return CircularProgressIndicator(); // Show loading indicator while user data is being fetched
                }
              },
            );
          } else {
            return Text('Review data not available'); // Show text when review data is not available
          }
        } else {
          return CircularProgressIndicator(); // Show loading indicator while review data is being fetched
        }
      }),
    );
  }
}
