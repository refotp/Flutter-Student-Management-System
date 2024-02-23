import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditStudentPageController extends GetxController {
  static EditStudentPageController get instace => Get.find();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController email = TextEditingController();
  RxString? inisialEmail;
  RxString namaLembaga = ''.obs;
  RxString initialNama = RxString('');
  String get namaInisial => initialNama.value!;
  Rx<File?> pickedFile = Rx<File?>(null);
  File? get imageFile => pickedFile.value;

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

  Future<void> updateStudentData(String documentId,
      Map<String, dynamic> updatedData, File? newPhoto) async {
    try {
      // Perbarui data siswa di Firestore
      await _firestore
          .collection('students')
          .doc(documentId)
          .update(updatedData);

      // Jika ada foto baru, unggah ke Firebase Storage dan perbarui URL foto di Firestore
      if (newPhoto != null) {
        // Upload foto baru ke Firebase Storage
        String imageUrl = await uploadPhoto(newPhoto, documentId);

        // Perbarui URL foto di Firestore
        await _firestore.collection('students').doc(documentId).update({
          'imageUrl': imageUrl,
        });
      }

      // Tampilkan snackbar atau pesan sukses
      Get.snackbar("Sukses", "Data siswa berhasil diperbarui");
    } catch (e) {
      print("Error updating student data: $e");
      // Tampilkan pesan error
      Get.snackbar("Error", "Gagal memperbarui data siswa");
    }
  }

  Future<String> uploadPhoto(File photo, String documentId) async {
    try {
      // Upload foto ke Firebase Storage
      TaskSnapshot task =
          await _storage.ref('students/$documentId/photo.jpg').putFile(photo);

      // Ambil URL foto yang baru diunggah
      String photoUrl = await task.ref.getDownloadURL();

      return photoUrl;
    } catch (e) {
      print("Error uploading photo: $e");
      throw Exception("Gagal mengunggah foto");
    }
  }
}
