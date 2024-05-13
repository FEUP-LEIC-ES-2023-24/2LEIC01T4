import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverPreferencesProvider extends ChangeNotifier {
  double _minimumRating = 4.0;
  int _minimumRidesTaken = 0;

  double get minimumRating => _minimumRating;
  int get minimumRidesTaken => _minimumRidesTaken;

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

  Future<void> savePreferences(String driverId) async {
    try {

      CollectionReference preferencesCollection = FirebaseFirestore.instance.collection('driver_preferences');
      print(preferencesCollection.id);


      await preferencesCollection.doc(driverId).set({
        'minimumRating': _minimumRating,
        'minimumRidesTaken': _minimumRidesTaken,
      });
      print('Preferences saved successfully');
    } catch (e) {
      print('Error saving preferences: $e');
    }
  }
}
