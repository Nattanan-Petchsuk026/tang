import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_widgets/menu/NearHospital.dart';
import 'home_widgets/menu/NearPharmacy.dart';
import 'home_widgets/menu/NearPolice.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key, required this.cardType}) : super(key: key);

  final String cardType;

  static Future<void> openMap(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'something went wrong! call emergency number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          NearPolice(onMapFunction: openMap),
          NearHospital(onMapFunction: openMap),
          NearPharmacy(onMapFunction: openMap),
        ],
      ),
    );
  }
}
