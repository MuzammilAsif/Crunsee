import 'package:crunsee/views/MainScreen.dart';
import 'package:crunsee/views/homepage.dart';
import 'package:crunsee/views/intro_screen.dart';
import 'package:crunsee/views/loginScreen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {

final ThemeData appTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: false,
  scaffoldBackgroundColor: const Color(0xFF121212), // Dark grey background
  primaryColor: const Color(0xFF2196F3), // Blue for highlights
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF2196F3), // Blue for AppBar and buttons
    secondary: Color(0xFF64B5F6), // Lighter blue for accents
    onPrimary: Colors.white, // Text on primary color
    onSecondary: Colors.white,
    background: Color(0xFF121212),
    onBackground: Colors.white,
    surface: Color(0xFF1E1E1E), // Slightly lighter than background
    onSurface: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2196F3),
    foregroundColor: Colors.white,
    elevation: 2,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white70),
    titleLarge: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF2196F3), // Blue buttons
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      textStyle: TextStyle(fontSize: 16),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xFF64B5F6), // Lighter blue for text buttons
    ),
  ),
);

////////////////// Theme Data ///////////////////////////

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: 'Crunsee',
     theme: ThemeData(
      fontFamily: 'Poppins',
      primarySwatch: Colors.blue,
      scaffoldBackgroundColor: Color.fromARGB(255, 32, 32, 32),
),
      home: Homepage(),
      debugShowCheckedModeBanner: false,
      // Routes to navigate to different screens
      routes: {
        '/welcomePage': (context) => IntroScreen(),
        '/loginPage': (context) => Loginscreen(),
        '/Mainscreen': (context) => Mainscreen(),
      },
    );
  }
}
void main() {
  runApp(MyApp());
}