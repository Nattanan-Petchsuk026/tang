// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<String> _getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return placemark.locality ?? 'Unknown Location';
      } else {
        return 'Unknown Location';
      }
    } catch (e) {
      print("Error getting address: $e");
      return 'Unknown Location';
    }
  }

  Future<void> _getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          currentPosition = position;
        });
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Location permission is not granted");
    }
  }

  // Function to launch Google Maps with the current position
  Future<void> _launchGoogleMaps() async {
    if (currentPosition != null) {
      print('Launching Google Maps with position: $currentPosition');
      double latitude = currentPosition!.latitude;
      double longitude = currentPosition!.longitude;
      String googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        print('Could not launch Google Maps with URL: $googleMapsUrl');
      }
    } else {
      print('Current position is null');
    }
  }

  // Function to show the bottom sheet with buttons
  Future<void> showModelSafeHome(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        double desiredHeight = MediaQuery.of(context).size.height / 1.4;
        double calculatedWidth =
            desiredHeight * 1.0; // You can adjust the multiplier as needed
        return Container(
          height: desiredHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Show YOUR CURRENT LOCATION"),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (currentPosition != null) {
                    _launchGoogleMaps(); // Call the function to launch Google Maps
                  } else {
                    print('Current position is null');
                  }
                },
                child: Text("GET LOCATION"),
              ),
              /*
              ElevatedButton(
                onPressed: () {
                  // Add your logic when the "SEND ALERT" button is pressed
                },
                child: Text("SEND ALERT"),
              ),*/
            ],
          ),
          width: calculatedWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModelSafeHome(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.transparent,
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFD3D3D3),
                Color(0xFFFFFFFF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Send Location"),
                      subtitle: Text("Share Location"),
                    ),
                    if (currentPosition != null)
                      ListTile(
                        title: Text("Current Location",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: FutureBuilder<String>(
                          future: _getAddressFromCoordinates(currentPosition!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text('Loading...');
                            } else if (snapshot.hasError) {
                              return Text('Error loading address');
                            } else {
                              return Text(snapshot.data ?? 'Unknown Location');
                            }
                          },
                        ),
                      ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/Location review-pana.jpg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
