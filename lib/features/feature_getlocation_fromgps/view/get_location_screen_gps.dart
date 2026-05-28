import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:test_test_test/config/app_string/app_key_string_ternationalization.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String location = "Unknown";

  Future<void> getUserLocation() async {
    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          location = 'Location permission denied';
        });
        return;
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Optional: convert to address
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks[0];

    setState(() {
      location =
          "${place.locality}, ${place.administrativeArea}, ${place.country}";
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Location')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(location),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getUserLocation,
              child: Text('Get Current Location'),
            ),
          ],
        ),
      ),
    );
  }
}
