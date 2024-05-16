import 'package:bus_driver_app/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatelessWidget {
  const App({super.key});
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
        backgroundColor: const Color(0xFF1B1212),
      ),
      backgroundColor: const Color(0xFF1B1212),
      body: const MainScreen(),
    );
  }
}
