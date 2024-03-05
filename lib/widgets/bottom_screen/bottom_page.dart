import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/bottom_screen/chat_screen.dart';
import 'package:flutter_application_3/widgets/bottom_screen/contacts_screen.dart';
import 'package:flutter_application_3/widgets/bottom_screen/home_screen.dart';

import 'package:flutter_application_3/widgets/bottom_screen/profile_page.dart';


class BottomPage extends StatefulWidget {
  const BottomPage({Key? key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int _currentIndex = 0; // Added for tracking the selected index

  List<Widget> pages = [
    HomeScreen(),
    ContactsPage(),
    ChatScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex], // Use the selected index
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavItem(Icons.home, 'Home', 0),
            buildNavItem(Icons.contacts, 'Contacts', 1),
            buildNavItem(Icons.chat, 'Chat', 2),
            buildNavItem(Icons.person, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index; // Update the current index when tapped
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: _currentIndex == index ? Colors.redAccent : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _currentIndex == index ? Colors.white : Colors.black,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: _currentIndex == index ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
