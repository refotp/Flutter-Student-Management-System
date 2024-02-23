import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle textButton(Color? warna) {
  return TextStyle(color: warna, fontSize: 16, fontWeight: FontWeight.w600);
}

TextStyle textTitle() {
  return const TextStyle(
      color: Color.fromARGB(255, 63, 101, 225),
      fontSize: 20,
      fontWeight: FontWeight.w700);
}

TextStyle textDesc() {
  return const TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
}

TextStyle globalTitle(double ukuran, Color? warna) {
  return TextStyle(color: warna, fontSize: ukuran, fontWeight: FontWeight.w600);
}

TextStyle globalSubTitle(double ukuran, Color? warna) {
  return TextStyle(color: warna, fontSize: ukuran);
}

OutlineInputBorder textFormFieldBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(color: Colors.amber, width: 1.0),
  );
}

OutlineInputBorder textFormFieldFocusedBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(color: Colors.blue, width: 2.0),
  );
}

OutlineInputBorder textFormFieldEnabledBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide:
        const BorderSide(color: Color.fromARGB(255, 209, 209, 209), width: 2.0),
  );
}

BoxConstraints textFormFieldBoxContstraints() {
  return BoxConstraints(
    maxHeight: 80.h,
  );
}

ButtonStyle buttonFormStyle(Color? warna) {
  return ButtonStyle(
    elevation: const MaterialStatePropertyAll(0),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    backgroundColor: MaterialStatePropertyAll(
      warna,
    ),
  );
}
