import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:testlatisedu/app/data/authenticationrepository.dart';
import 'package:testlatisedu/app/screens/profile/profilepage.dart';
import 'package:testlatisedu/app/screens/siswapage/siswapage.dart';

class Pages extends StatelessWidget {
  const Pages({
    super.key,
    required this.controller,
  });
  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Center(
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              switch (controller.selectedIndex) {
                case 0:
                  return const ProfilePage();
                case 1:
                  return const ProfilePage();
                case 2:
                  return handleLogout(context);
                default:
                  return const SiswaPage();
              }
            },
          ),
        ))
      ],
    );
  }
}

Widget handleLogout(BuildContext context) {
  return FutureBuilder<void>(
    future: AuthenticationRepository.instance.logout(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text('Error: ${snapshot.error}');
      } else {
        // Navigate to the desired page after successful logout
        return const Text('Logout successful');
      }
    },
  );
}
