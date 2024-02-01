import 'package:flutter/material.dart';
import 'package:mersin/views/home_screen.dart';
import 'package:mersin/views/parmacy_screen.dart';
import 'package:mersin/views/splash_screen.dart';
import 'package:mersin/views/travel_screen.dart';
import 'package:mersin/views/wheel_spinners_screen.dart';
import 'package:mersin/widgets/custom_tab_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  SplashScreen(),
    );
  }
}

