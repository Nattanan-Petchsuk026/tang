import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/bottom_screen/contacts_screen.dart';
import 'package:flutter_application_3/widgets/home_widgets/menu/EmergencyNumber.dart';
import 'package:flutter_application_3/widgets/home_widgets/menu/NearHospital.dart';
import 'package:flutter_application_3/widgets/home_widgets/menu/NearPharmacy.dart';
import 'package:flutter_application_3/widgets/home_widgets/menu/NearPolice.dart';
import 'package:flutter_application_3/widgets/home_widgets/safehome/SafeHome.dart';
import 'package:flutter_application_3/widgets/live_safe.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 0;
  bool showLanguageIcon = true;
  bool showSettingsIcon = true;

  getRandomQuote() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }

  void onMapFunction(String location) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LiveSafe(
                cardType: 'YourCardType',
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () {
                                // Handle back arrow press
                              },
                            ),
                            Spacer(),
                            Text(
                              "MENU",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.language, color: Colors.white),
                              onPressed: () {
                                // Handle language icon press
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Emergency",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContactsPage()),
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(child: EmergencyNumber()),
                          SizedBox(width: 10),
                          Expanded(
                            child: NearHospital(
                              onMapFunction: onMapFunction,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: NearPolice(
                            onMapFunction: (String location) {},
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: NearPharmacy(
                            onMapFunction: (String location) {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Send Location",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    SafeHome(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
