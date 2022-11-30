
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyp/screens/rider_screens/rider_earning_screen.dart';
import 'package:fyp/screens/rider_screens/rider_home_screen.dart';
import 'package:fyp/screens/rider_screens/rider_setting_screen.dart';

import '../../utils/fonts.dart';
import '../home_screen.dart';
import '../mechanic_screens/mechanic_inbox_screen.dart';
import '../mechanic_screens/mechanic_setting_screen.dart';
import '../mechanic_screens/mechanic_home_screen.dart';
import 'drawer/navigation_drawer_screen.dart';

class RiderDashboardScreen extends StatefulWidget {
  const RiderDashboardScreen({Key? key}) : super(key: key);

  @override
  State<RiderDashboardScreen> createState() => _RiderDashboardScreenState();
}

class _RiderDashboardScreenState extends State<RiderDashboardScreen> {
  int _currentIndex = 0;
  int _counter = 0;

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    RiderHomeScreen(),
    RiderEarningScreen(),
    RiderSettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      body: Center(
        child: _widgetOptions.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: primaryColor,
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => _currentIndex = index),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.yellow,
            textAlign: TextAlign.center,
          ),

          BottomNavyBarItem(
            icon: Icon(Icons.money),
            title: Text('Earning'),
            activeColor: Colors.yellow,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.yellow,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
