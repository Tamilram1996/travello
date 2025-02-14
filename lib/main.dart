import 'package:flutter/material.dart';
import 'package:travelo/UI/Splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travelo',
      debugShowCheckedModeBanner: false,  // Removes debug banner
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,  // Removes shadow for a cleaner look
          iconTheme: IconThemeData(color: Colors.black), // Ensures icons are visible
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // Choose a primary color
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
