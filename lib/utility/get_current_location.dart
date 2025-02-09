import 'dart:convert';
//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pollutant_inspection/models/my_result.dart';
import 'package:pollutant_inspection/models/result_model_.dart';
import 'package:pollutant_inspection/utility/show_modal_error.dart';

// class GetCurrentLocation extends StatefulWidget {
//   @override
//   _GetCurrentLocationState createState() => _GetCurrentLocationState();
// }
//
// class _GetCurrentLocationState extends State<GetCurrentLocation> {
//   String _locationMessage = "";
//   double? _latitude;
//   double? _longitude;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     // Request permission
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           _locationMessage = 'Location permissions are denied';
//         });
//         return;
//       }
//     }
//
//     // Get current position
//     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//     setState(() {
//       _latitude = position.latitude;
//       _longitude = position.longitude;
//       _locationMessage = "Latitude: $_latitude, Longitude: $_longitude";
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return
//        Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(_locationMessage),
//            SizedBox(height: 20),
//            ElevatedButton(
//              onPressed: _getCurrentLocation,
//              child: Text('Get Current Location'),
//            ),
//          ],
//        );
//   }

class Location {
  Future<MyResult> getCurrentLocation() async {
    // Request permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return MyResult(statusCode: 1,
            errors:  ['عدم دسترسی به لوکیشن'],
            data: null);
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Map<String, dynamic> locationData= {
      "lat": position.latitude,
      "lng": position.longitude,
    };

    return MyResult(
        data: jsonEncode(locationData),
        errors: null,
        statusCode: 0);
  }
}
