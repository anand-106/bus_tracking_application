import 'package:bus_driver_app/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RunScreen extends StatelessWidget {
  final MainScreen2 mainScreen;

  RunScreen({required this.mainScreen});

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
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 195, 0, 255)),
      ),
      backgroundColor: const Color(0xFF1B1212),
      body: PopScope(
        canPop: true, //When false, blocks the current route from being popped.
        onPopInvoked: (didPop) {
          //do your logic here:
          mainScreen.stopTracking();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  'Bus Location',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700)),
                ),
                Text(
                  'is sharing...',
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 195, 0, 255)),
                    onPressed: () {
                      mainScreen.stopTracking(); // Call stopTracking here
                      Navigator.pop(context);
                    },
                    label: const Text(
                      'Stop',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    icon: const Icon(
                      Icons.stop,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
                Lottie.asset('lib/assets/location.json',
                    width: 400, height: 400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
