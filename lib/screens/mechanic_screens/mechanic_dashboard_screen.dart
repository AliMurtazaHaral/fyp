
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/fonts.dart';
import '../home_screen.dart';
import 'mechanic_home_screen.dart';
import 'mechanic_inbox_screen.dart';
import 'mechanic_setting_screen.dart';

class MechanicDashboardScreen extends StatefulWidget {
  const MechanicDashboardScreen({Key? key}) : super(key: key);

  @override
  State<MechanicDashboardScreen> createState() =>
      _MechanicDashboardScreenState();
}

class _MechanicDashboardScreenState extends State<MechanicDashboardScreen> {
  int _currentIndex = 0;
  int _counter = 0;

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    MechanicHomeScreen(),
    MechanicInboxScreen(),
    MechanicSettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: Icon(Icons.message),
            title: Text('Messages'),
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
