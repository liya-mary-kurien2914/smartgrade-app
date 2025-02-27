import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/input_page.dart';
import 'screens/result_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/input': (context) => InputPage(),
    },
    onGenerateRoute: (settings) {
      if (settings.name == '/result') {
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => ResultPage(arguments: args),
        );
      }
      return null; // Default case
    },
  ));
}
