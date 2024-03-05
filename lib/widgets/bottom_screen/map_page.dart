import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapPage extends StatefulWidget {
  final double? latitude, longitude;
  const MapPage({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(13.7563, 100.5018),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: <Marker>[
          Marker(
            markerId: MarkerId("location"),
            position: LatLng(widget.latitude!, widget.longitude!),
            icon: BitmapDescriptor.defaultMarker,
          ),
        ].toSet(),
      ),
    );
  }

  // get position method
  Future<void> getPosition() async {
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      Position datas = await _determinePosition();
      await getAddressFromLatLong(datas);
    }
  }

  // Method to get the current position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied, we cannot request permissions.');
      }
    }

    // Get the current position.
    return await Geolocator.getCurrentPosition();
  }

  // Method to get the address from latitude and longitude
  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    print(placemarks);

    Placemark place = placemarks[0];

    var address =
        '${place.street}, ${place.subLocality}, ${place.thoroughfare}, ${place.locality}, ${place.postalCode}';
    print(address);
    var lat = position.latitude;
    var lon = position.longitude;
    Navigator.push(context, MaterialPageRoute(builder: (_) => MapPage(latitude: lat, longitude: lon)));
  }
}
