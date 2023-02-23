import 'package:idental_n_patient/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:iconly/iconly.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:idental_n_patient/history.dart';
// import 'package:doctor_appointment_app/login.dart';
// import 'package:idental/upload.dart';

import '../profilePage.dart';
import '../try.dart';
// import '../screens/appointment_screen.dart';

class HomeScreen extends StatefulWidget {
  //const HomeScreen({key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedScreenIndex = 0;
  final List _screens = [
    {"screen": HomePage()},
    {"screen": try2()},
    {"screen": HistoryScreen()},
    {"screen": profileScreen()}
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex]["screen"],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 9
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
             padding:const EdgeInsets.all(15.0),
            child: GNav(
              backgroundColor: Colors.white,
              color: Colors.teal,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.teal,
              gap: 8,
              selectedIndex: _selectedScreenIndex,
              onTabChange: _onItemTapped,
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10,
              ),
              tabs: [
                GButton(
                  icon: Icons.home,
                  iconColor: Colors.black,
                  text: 'Home',
                    ),
                GButton(
                  icon: Icons.calendar_today,
                  iconColor: Colors.black,
                  text: 'Appointment',
                ),
                GButton(
                  icon: Icons.history,
                  iconColor: Colors.black,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.person,
                  iconColor: Colors.black,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


