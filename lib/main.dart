// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roam_flutter/roam_flutter.dart';

void main() {
  runApp(
    const MaterialApp(
      home: RoamFlutterExampleSelfTracking(),
    ),
  );
}

class RoamFlutterExampleSelfTracking extends StatefulWidget {
  const RoamFlutterExampleSelfTracking({super.key});

  @override
  State<RoamFlutterExampleSelfTracking> createState() => _RoamFlutterExampleSelfTrackingState();
}

class _RoamFlutterExampleSelfTrackingState extends State<RoamFlutterExampleSelfTracking> {
  String longitude = "";
  String latitude = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Roam Self Tracking Example",
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _initialiseRoamSDK,
              child: const Text("Initialise SDK"),
            ),
            // spacing
            const SizedBox(height: 32.0),

            ElevatedButton(
              onPressed: _startTracking,
              child: const Text("Start Tracking"),
            ),
            // spacing
            const SizedBox(height: 32.0),

            ElevatedButton(
              onPressed: _stopTracking,
              child: const Text("Stop Tracking"),
            ),
            // spacing
            const SizedBox(height: 32.0),

            if (longitude != "" && latitude != "") ...[
              Text("Longitude: $longitude"),
              // spacing
              const SizedBox(height: 12.0),
              Text("Latitude: $latitude"),
            ],
          ],
        ),
      ),
    );
  }

  /// Member Functions
  ///
  ///

  _initialiseRoamSDK() async {
    // Initialise the SDK
    Roam.initialize(publishKey: 'SDK-KEY-HERE');
    await Permission.location.request().isGranted;
    if (await Permission.location.request().isGranted) {
      Permission.locationAlways.request();
    } else {
      await Permission.location.request();
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Material(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                "Permission Denied. Please enable it in System Settings and",
              ),
            ),
          );
        },
      );
    }
  }

  void _startTracking() async {
    Map<String, dynamic> fitnessTracking = {"timeInterval": 10};
    // Roam.subscribeEvents();
    Roam.subscribeLocation();

    Roam.allowMockLocation(allow: true);
    await Roam.onLocation((location) {
      print("Location: ");
      print(jsonEncode(location));
    });

    Roam.startTracking(trackingMode: "active", customMethods: fitnessTracking);

    // await Roam.toggleListener(
    //     locations: true,
    //     events: true,
    //     callBack: ({user}) {
    //       //Do something with user
    //       print(user);
    //     });
  }

  void _stopTracking() async {
    Roam.stopTracking();
  }
}
