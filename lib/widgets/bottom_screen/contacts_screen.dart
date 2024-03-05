import 'package:flutter/material.dart';
import 'package:flutter_application_3/widgets/home_widgets/emergencies/AmbulanceEmergency.dart';
import 'package:flutter_application_3/widgets/home_widgets/emergencies/FirebrigadeEmergency.dart';
import 'package:flutter_application_3/widgets/home_widgets/emergencies/HighwayPatrol.dart';
import 'package:flutter_application_3/widgets/home_widgets/emergencies/ProvincialElectricityAuthority.dart';
import 'package:flutter_application_3/widgets/home_widgets/emergencies/WaterEmergency.dart';
import 'package:flutter_application_3/widgets/home_widgets/emergencies/Policeemergency.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<String> contacts = [
    "Ambulance",
    "Police",
    "Firebrigade",
    "WaterEmergency",
    "HighwayPatrol",
    "ProvincialElectricityAuthority",
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<String> filteredContacts = contacts
        .where((contact) =>
            contact.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  for (String contact in filteredContacts)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(child: getContactWidget(contact)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getContactWidget(String contact) {
    switch (contact) {
      case "Ambulance":
        return AmbulanceEmergency();
      case "Police":
        return PoliceEmergency();
      case "Firebrigade":
        return FirebrigadeEmergency();
      case "WaterEmergency":
        return WaterEmergency();
      case "HighwayPatrol":
        return HighwayPatrol();
      case "ProvincialElectricityAuthority":
        return ProvincialElectricityAuthority();
      default:
        return Container(); // Return an empty container for unknown contacts
    }
  }
}
