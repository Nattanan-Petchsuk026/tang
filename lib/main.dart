import 'package:flutter/material.dart';
import 'package:flutter_application_3/config/Themes.dart';
import 'package:flutter_application_3/widgets/bottom_screen/bottom_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOS emergency',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      home:BottomPage(),
    );
    
  }
}
