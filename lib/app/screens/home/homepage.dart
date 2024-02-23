import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:testlatisedu/app/controller/homepagecontroller.dart';
import 'package:testlatisedu/app/screens/home/pages.dart';
import 'package:testlatisedu/app/widgets/sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomePageController();
    final sidebarX = SidebarXController(selectedIndex: 0, extended: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            child: Image.asset('assets/logo250x250.png'),
            onTap: () => controller.openDrawer(),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'LatisEdu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      key: controller.scaffoldState,
      drawer: SideBar(controller: sidebarX),
      body: Pages(controller: sidebarX),
    );
  }
}
