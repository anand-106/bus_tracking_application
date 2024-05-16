import 'package:flutter/material.dart';
import 'package:bus_tracking_driver/background.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bus_tracking_driver/open_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(title: 'Buss Tracking', home: OpenPage()));
}
