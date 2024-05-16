import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:bus_tracking_driver/database.dart';
import 'package:bus_tracking_driver/get_time.dart';
import 'package:google_fonts/google_fonts.dart';

String? chosenValue;
String? chosenStop;
List<String> keyList = [];
List<String> stopList = [];
List<String> stopList2 = [];
StreamSubscription? subscription;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List<LatLng> routeLatLng = [];
  LatLng currentMarkerPosition = const LatLng(0, 0);

  String link = '';
  String link2 = '';
  LatLng destination = const LatLng(0, 0);
  LatLng userPos = const LatLng(0, 0);
  LatLng userPos2 = const LatLng(0, 0);
  LatLng muthootPos = const LatLng(9.963850, 76.408457);
  String eta = '';
  String dbLink = '';
  LatLng dbPos = const LatLng(0, 0);

  double sLat = 9.963850;
  double sLon = 76.408457;
  double dbLat = 0;
  double dbLon = 0;
  double lat = 0;
  double lng = 0;
  // Initial marker position

  @override
  void initState() {
    super.initState();

    initializeAsyncData();

    // Call the method to fetch the route coordinates when the widget is initialized
    // getRoute();
    // listenToDatabaseChanges();
  }

  Future<void> initializeAsyncData() async {
    // Perform asynchronous operations here

    await listenToDatabaseChanges();
    await getDBlink();
    print('The db link is $dbLink');
    await getRoute(dbLink);
    await setLoc();
    print(link2);
    await updateTime();
    setState(() {
      destination = dbPos;
    });
  }

  Future<void> updateTime() async {
    String newEta = await getTime(link2, currentMarkerPosition, userPos2);
    setState(() {
      eta = newEta;
    });
  }

  Future<void> getRoute(String link) async {
    this.link;
    // Convert the URL string into a Uri object
    print(link);
    Uri url = Uri.parse(link);

    // Make the HTTP request and wait for the response
    http.Response response = await http.get(url);

    // Extract the response body as a string
    var decodedResponse = json.decode(response.body);
    // Now you can work with the response data

    List<dynamic> coordinates =
        decodedResponse['routes'][0]['geometry']['coordinates'];

    // Convert coordinates to LatLng objects with swapped values
    List<LatLng> newRouteLatLng = coordinates.map((coordinate) {
      // Swap the latitude and longitude values
      double mlat = coordinate[1];
      double mlng = coordinate[0];
      return LatLng(mlat, mlng);
    }).toList();
    print('route get successsful');
    // Print the list of LatLng objects
    setState(() {
      routeLatLng = newRouteLatLng;
    });
  }

  void printTime() {
    getTime(link, muthootPos, currentMarkerPosition).then((value) {
      print(value); // This will print the double value
    });
  }

  Future<void> setLoc() async {
    print('hi fucker');
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('$chosenValue/stops/$chosenStop');

    final snapshot = await databaseReference.get();
    if (snapshot.exists) {
      double dbLat =
          (snapshot.value as Map<dynamic, dynamic>?)?['lat'] as double;
      double dbLon =
          (snapshot.value as Map<dynamic, dynamic>?)?['lon'] as double;
      print(dbLat);
      link2 =
          "https://api.mapbox.com/directions-matrix/v1/mapbox/driving/$dbLon,$dbLat;$lng,$lat?approaches=curb;curb&access_token=pk.eyJ1IjoiYW5hbmQxMDYiLCJhIjoiY2x1dXlwMGdiMGFnMjJxbW9jcWo2eXBjMCJ9.gBCavskm54ytN6xsD0CgXQ";
      print(link2);
      userPos = LatLng(dbLat, dbLon);

      setState(() {
        userPos2 = userPos;
      });
    } else {
      print('No data available.');
    }
  }

  void stopListeningToDatabaseChanges() {
    if (subscription != null) {
      subscription!.cancel();
      print('Stopped listening to database changes');
    }
  }

  Future<void> listenToDatabaseChanges() async {
    print('Listening to database changes...');
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('$chosenValue');

    subscription = databaseReference.onValue.listen((event) async {
      print('Database change detected');
      // Retrieve the new marker position from Firebase
      DataSnapshot snapshot = event.snapshot;
      String? latString =
          (snapshot.value as Map<dynamic, dynamic>?)?['lat'] as String?;
      String? lngString =
          (snapshot.value as Map<dynamic, dynamic>?)?['lon'] as String?;
      dbLink = (snapshot.value as Map<dynamic, dynamic>?)?['link'] as String;
      dbLat =
          (snapshot.value as Map<dynamic, dynamic>?)?['pos']['lat'] as double;
      dbLon =
          (snapshot.value as Map<dynamic, dynamic>?)?['pos']['lon'] as double;
      dbPos = LatLng(dbLat, dbLon);

      lat = double.tryParse(latString ?? '') ?? 0.0;
      lng = double.tryParse(lngString ?? '') ?? 0.0;

      print('Muthoot position: $muthootPos');
      print('Current marker position: $currentMarkerPosition');

      print(link);
      // Wait for getTime to execute and get the value

      // Update the marker position and ETA
      setState(() {
        currentMarkerPosition = LatLng(lat, lng);
        print('Updated marker position: $currentMarkerPosition');
        print('ETA: $eta');
      });
    });
  }

  Future<void> getDBlink() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('$chosenValue');

    final snapshot = await databaseReference.get();
    if (snapshot.exists) {
      String dbLink1 =
          (snapshot.value as Map<dynamic, dynamic>?)?['link'] as String;
      setState(() {
        dbLink = dbLink1;
        print(dbLink);
      });
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Where is my Bus",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
          ),
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 195, 0, 255)),
        ),
        backgroundColor: const Color(0xFF1B1212),
        body: PopScope(
          canPop:
              true, //When false, blocks the current route from being popped.
          onPopInvoked: (didPop) {
            //do your logic here:
            stopListeningToDatabaseChanges();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 500,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: FlutterMap(
                      options: const MapOptions(
                        initialCenter: LatLng(9.963850, 76.408457),
                        initialZoom: 11,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://api.mapbox.com/styles/v1/anand106/cluuzfp5x000r01r74eii1y4t/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiYW5hbmQxMDYiLCJhIjoiY2x1dXlwMGdiMGFnMjJxbW9jcWo2eXBjMCJ9.gBCavskm54ytN6xsD0CgXQ',
                          additionalOptions: const {
                            'accessToken':
                                'pk.eyJ1IjoiYW5hbmQxMDYiLCJhIjoiY2x1dXlwMGdiMGFnMjJxbW9jcWo2eXBjMCJ9.gBCavskm54ytN6xsD0CgXQ',
                            'id': 'mapbox.mapbox-streets-v8'
                          },
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                                points: routeLatLng,
                                color: const Color.fromARGB(255, 255, 0, 0),
                                strokeWidth: 5),
                          ],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: muthootPos,
                              width: 80,
                              height: 80,
                              child: const Icon(
                                Icons.location_pin,
                                color: Color.fromARGB(255, 255, 0, 0),
                                size: 35,
                              ),
                            ),
                            Marker(
                              point: currentMarkerPosition,
                              width: 80,
                              height: 80,
                              child: const Icon(
                                Icons.directions_bus,
                                color: Color.fromARGB(255, 9, 0, 134),
                                size: 35,
                              ),
                            ),
                            Marker(
                              point: dbPos,
                              width: 80,
                              height: 80,
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.green,
                                size: 35,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    focusColor: const Color(0xFF1B1212),
                    dropdownColor: const Color(0xFF1B1212),
                    value: chosenValue,
                    //elevation: 5,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    iconEnabledColor: const Color.fromARGB(255, 195, 0, 255),
                    items:
                        keyList.map<DropdownMenuItem<String>>((String value) {
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
                      "Select Bus",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String? value) {
                      // await getStopList(value);
                      setState(() {
                        chosenValue = value;
                        stopList2 = stopList;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    focusColor: const Color(0xFF1B1212),
                    dropdownColor: const Color(0xFF1B1212),
                    value: chosenStop,
                    //elevation: 5,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    iconEnabledColor: const Color.fromARGB(255, 195, 0, 255),
                    items:
                        stopList2.map<DropdownMenuItem<String>>((String value) {
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
                      "Select Stop",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        chosenStop = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () async {
                        if (chosenValue != null && chosenStop != null) {
                          await getDBlink();
                          await getRoute(dbLink);
                          await setLoc();
                          print(link2);
                          await updateTime();
                          setState(() {
                            destination = dbPos;
                          });
                        }
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              const Color.fromARGB(255, 195, 0, 255)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                eta,
                style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
              )
            ],
          ),
        ));
  }
}
