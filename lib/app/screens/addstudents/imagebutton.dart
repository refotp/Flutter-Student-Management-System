import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:testlatisedu/app/widgets/stylewidget.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({
    super.key,
    this.icon,
    required this.text,
  });
  final IconData? icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.orange[800],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: globalTitle(16, Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
