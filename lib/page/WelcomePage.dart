import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/chat.png',
                    width: 250, // Set the desired width
                    height: 250, // Set the desired height
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/boy.png',
                    width: 135, // Set the desired width
                    height: 135, // Set the desired height
                  ),
                  SizedBox(width: 10), // Adjust the width between boy and girl images
                  Image.asset(
                    'assets/girl.png',
                    width: 170, // Set the desired width
                    height: 170, // Set the desired height
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
