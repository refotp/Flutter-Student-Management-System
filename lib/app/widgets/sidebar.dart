import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key, required this.controller});
  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      showToggleButton: false,
      theme: const SidebarXTheme(width: 120),
      controller: controller,
      items: const [
        SidebarXItem(
          icon: Icons.person,
          label: 'Siswa',
        ),
        SidebarXItem(icon: Icons.perm_identity, label: 'Profile'),
        SidebarXItem(icon: Icons.logout, label: 'Logout'),
      ],
    );
  }
}
