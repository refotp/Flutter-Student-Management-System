import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testlatisedu/app/widgets/stylewidget.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Image.asset(
          'assets/logo3.png',
          width: 120.w,
          height: 120.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: globalTitle(20, Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              subtitle,
              style: globalSubTitle(16, Colors.grey),
            ),
          ],
        )
      ],
    );
  }
}
