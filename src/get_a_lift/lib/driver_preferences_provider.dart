import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverPreferencesProvider extends ChangeNotifier {
  double _minimumRating = 0;
  int _minimumRidesTaken = 0;

  double get minimumRating => _minimumRating;
  int get minimumRidesTaken => _minimumRidesTaken;

  bool _isDriver = false;
  String? _driverUID;

  bool get isDriver => _isDriver;
  String? get driverUID => _driverUID;

  void updateMinimumRating(double rating) {
    _minimumRating = rating;
    notifyListeners();
    print('Minimum rating updated: $_minimumRating');
  }

  void updateMinimumRidesTaken(int rides) {
    _minimumRidesTaken = rides;
    notifyListeners();
    print('Minimum rides taken updated: $_minimumRidesTaken');
  }

  void setDriverInfo({required bool isDriver, String? driverUID}) {
    _isDriver = isDriver;
    _driverUID = driverUID;
  }

  Future<void> savePreferences(String userDocumentId) async {
    try {
      CollectionReference preferencesCollection = FirebaseFirestore.instance.collection('driver_preferences');

      // Check if preferences document already exists for this user
      QuerySnapshot<Object?> snapshot = await preferencesCollection.where('userDocumentId', isEqualTo: userDocumentId).get();
      if (snapshot.docs.isNotEmpty) {
        // If preferences document exists, update it
        await snapshot.docs.first.reference.update({
          'userDocumentId': userDocumentId,
          'minimumRating': _minimumRating,
        });
        print('Preferences updated successfully for user: $userDocumentId');
      } else {
        // If preferences document doesn't exist, create a new one
        DocumentReference docRef = await preferencesCollection.add({
          'userDocumentId': userDocumentId,
          'minimumRating': _minimumRating,
        });
        print('New preferences created successfully with document ID: ${docRef.id} for user: $userDocumentId');
      }
    } catch (e) {
      print('Error saving preferences: $e');
    }
  }
}
