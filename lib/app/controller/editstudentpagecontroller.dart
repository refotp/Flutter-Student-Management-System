import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditStudentPageController extends GetxController {
  static EditStudentPageController get instace => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController email = TextEditingController();
  RxString? inisialEmail;
  RxString namaLembaga = ''.obs;
  RxString initialNama = RxString('');
  String get namaInisial => initialNama.value;
  Rx<File?> pickedFile = Rx<File?>(null);
  File? get imageFile => pickedFile.value;
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

  Future<void> updateStudentData(String documentId,
      Map<String, dynamic> updatedData, File? newPhoto) async {
    try {
      openDialig();
      await _firestore
          .collection('Students')
          .doc(documentId)
          .update(updatedData);

      if (newPhoto != null) {
        String imageUrl = await uploadPhoto(newPhoto, documentId);

        await _firestore.collection('Students').doc(documentId).update({
          'imageUrl': imageUrl,
        });
      }
      Get.back();
      Get.snackbar("Sukses", "Data siswa berhasil diperbarui",
          backgroundColor: Colors.green[800], colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", "Gagal memperbarui data siswa");
    }
  }

  Future<String> uploadPhoto(File photo, String documentId) async {
    try {
      TaskSnapshot task =
          await _storage.ref('students/$documentId/photo.jpg').putFile(photo);

      String photoUrl = await task.ref.getDownloadURL();

      return photoUrl;
    } catch (e) {
      throw Exception("Gagal mengunggah foto");
    }
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
