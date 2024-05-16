import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bus_tracking_driver/background.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:lottie/lottie.dart';

class OpenPage extends StatefulWidget {
  const OpenPage({super.key});

  @override
  State<OpenPage> createState() => _OpenPageState();
}

class _OpenPageState extends State<OpenPage> {
  MyAppState callObj = MyAppState();

  @override
  void initState() {
    super.initState();
    getKeyList();
    // Call the method to fetch the route coordinates when the widget is initialized
    // getRoute();
    // listenToDatabaseChanges();
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

  Future<void> getStopList(String? stop) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref('$stop/stops');

    final snapshot = await databaseReference.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;

      setState(() {
        stopList = values.keys.map((key) => key.toString()).toList();
        print(stopList);
      });
    } else {
      print('No data available.');
    }
  }

  @override
  Widget build(context) {
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
        ),
        backgroundColor: const Color(0xFF141218),
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Card.outlined(
                color: const Color(0xFF141218),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    side: BorderSide(color: Color.fromARGB(255, 195, 0, 255))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Select Bus',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w700)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          child: DropdownButton<String>(
                            focusColor: const Color(0xFF1B1212),
                            dropdownColor: const Color(0xFF1B1212),
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_downward),
                            value: chosenValue,
                            //elevation: 5,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            iconEnabledColor:
                                const Color.fromARGB(255, 195, 0, 255),
                            items: keyList
                                .map<DropdownMenuItem<String>>((String value) {
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
                              "Select Route",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String? value) async {
                              await getStopList(value);
                              setState(() {
                                chosenValue = value;
                                stopList2 = stopList;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          width: 150,
                          child: DropdownButton<String>(
                            focusColor: const Color(0xFF1B1212),
                            isExpanded: true,
                            dropdownColor: const Color(0xFF1B1212),
                            icon: const Icon(
                              Icons.arrow_downward,
                              color: Color.fromARGB(255, 195, 0, 255),
                            ),
                            value: chosenStop,
                            //elevation: 5,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            iconEnabledColor:
                                const Color.fromARGB(255, 195, 0, 255),
                            items: stopList2
                                .map<DropdownMenuItem<String>>((String value) {
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
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextButton.icon(
                      label: Text(
                        'Confirm',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (chosenValue != null && chosenStop != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyApp()),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              const Color.fromARGB(255, 195, 0, 255),
                          fixedSize: const Size.fromWidth(325)),
                      icon: const Icon(
                        Icons.check,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Lottie.asset('lib/assets/bus.json')
          ],
        ));
  }
}
