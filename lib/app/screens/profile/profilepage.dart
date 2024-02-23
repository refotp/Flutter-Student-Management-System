import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.black),
            child: Image.asset(
              'assets/fotoku.jpg',
              width: 240,
              height: 240,
              fit: BoxFit.cover,
            ),
          )
        ],
      )),
    );
  }
}
