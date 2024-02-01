import 'package:flutter/material.dart';
import 'package:mersin/views/home_screen.dart';
import 'package:mersin/views/food_screen.dart';
import 'package:mersin/views/travel_screen.dart';
import 'package:mersin/views/wheel_spinners_screen.dart';
import 'package:mersin/views/parmacy_screen.dart';


class MyTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        body: TabBarView(
          children: [
            HomeScreen(),
            FoodScreen(),
            TravelScreen(),
            SpinningWhelePage(),
            PharmacyPage(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.fastfood_rounded), text: 'Food'),
              Tab(icon: Icon(Icons.museum), text: 'Travel'),
              Tab(icon: Icon(Icons.whatshot), text: 'Spinning Wheel'),
              Tab(icon: Icon(Icons.local_pharmacy), text: 'Pharmacy'),
            ],
          ),
        ),
      ),
    );
  }
}

