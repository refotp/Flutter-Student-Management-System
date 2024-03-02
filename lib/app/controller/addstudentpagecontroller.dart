import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:testlatisedu/app/data/firebaseservice.dart';

class AddStudentPageController extends GetxController {
  static AddStudentPageController get instance => Get.find();
  final FirebaseService _firebaseService = FirebaseService();

  Rx<File?> pickedFile = Rx<File?>(null);
  File? get imageFile => pickedFile.value;

  TextEditingController namaLengkap = TextEditingController();
  TextEditingController email = TextEditingController();
  RxString namaLembaga = ''.obs;
  bool isImageSelected = false;

  Future<void> captureImageFromCamera() async {
    if (isImageSelected) {
      resetImageSelection();
    }
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedFile.value = await compressImage(File(image.path), 100);
      isImageSelected = true;

      update();
    }
  }

  Future<void> pickImageFromGallery() async {
    if (isImageSelected) {
      resetImageSelection();
    }
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedFile.value = await compressImage(File(image.path), 100);
      isImageSelected = true;

      update();
    }
  }

  Future<File> compressImage(File file, int maxSizeKB) async {
    img.Image? image = img.decodeImage(file.readAsBytesSync());
    int quality = 100;
    List<int> compressedImage = file.readAsBytesSync();

    while (compressedImage.length > maxSizeKB * 1024) {
      compressedImage = img.encodeJpg(image!, quality: quality);
      quality -= 10;
      if (quality <= 0) break;
    }

    Directory tempDir = await getTemporaryDirectory();
    File compressedFile = File('${tempDir.path}/compressed_image.jpg');
    await compressedFile.writeAsBytes(compressedImage);
    return compressedFile;
  }

  Future<void> saveStudentData() async {
    try {
      openDialig();
      await _firebaseService.saveStudentData(namaLengkap.text,
          email.text.trim(), namaLembaga.value, imageFile!.path);
      Get.back();
      Get.snackbar("Sukses", "Data siswa berhasil disimpan",
          backgroundColor: Colors.green[800], colorText: Colors.white);
      resetForm();
    } catch (e) {
      Get.back();
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

  void resetImageSelection() {
    pickedFile.value = null;
    isImageSelected = false;
    update();
  }
}
