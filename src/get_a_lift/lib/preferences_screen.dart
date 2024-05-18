import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'driver_preferences_provider.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final driverPreferences = Provider.of<DriverPreferencesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Set Your Preferences',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () {
                      _setRating(i, driverPreferences);
                    },
                    child: Icon(
                      i <= driverPreferences.minimumRating ? Icons.star : Icons.star_border,
                      color: Colors.yellow,
                      size: 40,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _savePreferences(context, driverPreferences);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Save Preferences',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setRating(int starValue, DriverPreferencesProvider driverPreferences) {
    double newRating = starValue.toDouble();
    driverPreferences.updateMinimumRating(newRating);
  }

  void _savePreferences(BuildContext context, DriverPreferencesProvider driverPreferences) async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Retrieve the user's UID
      String userId = user.uid;

      // Save preferences using the user's UID as the document ID in 'driver_preferences' collection
      await driverPreferences.savePreferences(userId);
      Navigator.pop(context);
    } else {
      print('Error: Current user not found.');
    }
  }
}