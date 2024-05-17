import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Roam Self Tracking Example",
        ),
      ),
    );
  }
}
