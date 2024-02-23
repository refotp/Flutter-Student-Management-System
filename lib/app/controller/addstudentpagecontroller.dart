import 'dart:io';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testlatisedu/app/data/firebaseservice.dart';

class AddStudentPageController extends GetxController {
  static AddStudentPageController get instance => Get.find();
  final FirebaseService _firebaseService = FirebaseService();

  Rx<File?> pickedFile = Rx<File?>(null);
  File? get imageFile => pickedFile.value;

  TextEditingController namaLengkap = TextEditingController();
  TextEditingController email = TextEditingController();
  RxString namaLembaga = ''.obs;

  Future<void> captureImageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedFile.value = File(image.path);
      update();
    }
  }

  Future<void> pickImageFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedFile.value = File(image.path);
      update();
    }
  }

  Future<void> saveStudentData() async {
    try {
      openDialig();
      await _firebaseService.saveStudentData(namaLengkap.text,
          email.text.trim(), namaLembaga.value, imageFile!.path);
      Get.back();
      Get.snackbar("Sukses", "Data siswa berhasil disimpan");
      resetForm();
    } catch (e) {
      Get.back();
      print("Error saving student data: $e");
      Get.snackbar("Error", "Gagal menyimpan data siswa");
    }
  }

  void resetForm() {
    namaLengkap.clear();
    email.clear();
    pickedFile.value = null;
    update();
  }

  void openDialig() {
    Get.dialog(
        Dialog(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const SizedBox(
            width: 100,
            height: 150,
            child: SpinKitCubeGrid(
              size: 100,
              color: Colors.white,
            ),
          ),
        ),
        barrierDismissible: false);
  }
}
