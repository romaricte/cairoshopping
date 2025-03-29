import 'package:cairoshopping/ui/intro/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:cairoshopping/constants/color_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
 Widget build(BuildContext context) {
    ThemeData themeData = ThemeData(primaryColor: primaryColor);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const SplashScreen(),
    );
  }
}

