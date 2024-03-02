import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key, required this.controller});
  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      headerBuilder: (context, extended) => Container(
        width: 240,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage('assets/logo3.png'),
              fit: BoxFit.cover,
            )),
      ),
      showToggleButton: false,
      theme: SidebarXTheme(
          width: 240,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 195, 117, 0),
          ),
          itemPadding: EdgeInsets.all(20),
          selectedItemPadding: EdgeInsets.all(20),
          selectedTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
          selectedIconTheme: const IconThemeData(color: Colors.white, size: 28),
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
          iconTheme: const IconThemeData(color: Colors.white, size: 28),
          selectedItemDecoration: BoxDecoration(
              color: Color.fromARGB(43, 255, 255, 255),
              borderRadius: BorderRadius.circular(5))),
      controller: controller,
      items: const [
        SidebarXItem(
          icon: Icons.person,
          label: 'Siswa',
        ),
        SidebarXItem(icon: Icons.perm_identity, label: 'About me'),
        SidebarXItem(icon: Icons.logout, label: 'Logout'),
      ],
    );
  }
}
