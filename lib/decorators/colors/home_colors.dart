import 'package:flutter/material.dart';

// Scaffold body color
Color? scaffoldBackground;

// Bottom Nav-Bar Colors
Color? bottomNavBarColor;
Color? activeColor;
Color? gNavColor;
Color? gNavBackground;
Color? gTabBackground;

applyNavBarColors() {
  bottomNavBarColor = Colors.white;
  activeColor = const Color.fromARGB(255, 0, 18, 138);
  gNavColor = const Color.fromARGB(255, 6, 0, 61);
  gNavBackground = Colors.white;
  gTabBackground = const Color.fromARGB(255, 230, 250, 255);

  // Scaffold body color
  scaffoldBackground = Colors.white;
}

