import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'package:bus_driver_app/run.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() {
    return MainScreen2();
  }
}

class MainScreen2 extends State<MainScreen> {
  StreamSubscription<Position>? positionStreamSubscription;
  Position? _currentPosition;
  String? _chosenValue;
  List<String> keyList = [];

  @override
  void initState() {
    super.initState();
    getKeyList();
  }

  @override
  void dispose() {
    stopTracking();
    super.dispose();
  }

  Future<void> getKeyList() async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

    final snapshot = await databaseReference.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        keyList = values.keys.map((key) => key.toString()).toList();
        print(keyList);
      });
    } else {
      print('No data available.');
    }
  }

  void _startTracking() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 150,
    );

    positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) async {
      // Send location to Firebase Realtime Database
      double newlat = position.latitude;
      double newlon = position.longitude;
      DatabaseReference locationRef =
          FirebaseDatabase.instance.ref('$_chosenValue');
      await locationRef.update({
        'lat': '$newlat',
        'lon': '$newlon',
      });
      setState(() {
        _currentPosition = position;
      });
    });
  }

  void stopTracking() {
    if (positionStreamSubscription != null) {
      positionStreamSubscription!.cancel();
    }
  }

  void push() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RunScreen(mainScreen: this)),
    );
  }

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 75,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Route',
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          DropdownButton<String>(
            focusColor: const Color(0xFF1B1212),
            dropdownColor: const Color(0xFF1B1212),
            value: _chosenValue,
            //elevation: 5,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            iconEnabledColor: const Color.fromARGB(255, 195, 0, 255),
            items: keyList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              );
            }).toList(),
            hint: const Text(
              "Please choose a Route",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            onChanged: (String? value) {
              setState(() {
                _chosenValue = value;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 195, 0, 255)),
                onPressed: () async {
                  if (_chosenValue != null) {
                    await Geolocator.requestPermission();
                    _startTracking();
                    push();
                  }
                },
                icon: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
                label: const Text(
                  'Start',
                  style: TextStyle(color: Colors.white),
                )),
          ),
          Lottie.asset('lib/assets/bus.json'),
        ],
      ),
    );
  }
}
