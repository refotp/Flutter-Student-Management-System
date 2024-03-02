import 'package:flutter/material.dart';
import 'package:testlatisedu/app/widgets/stylewidget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox.fromSize(
              size: const Size.fromRadius(100),
              child: Image.asset('assets/fotoku.jpg', fit: BoxFit.cover),
            ),
          ),
          Text(
            'Name : Refo Tri Putra',
            style: globalTitle(14, Colors.black),
          ),
        ],
      )),
    );
  }
}
