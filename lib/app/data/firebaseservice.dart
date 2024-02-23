import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> saveStudentData(String namaLengkap, String email,
      String namaLembaga, String imagePath) async {
    QuerySnapshot snapshot = await _firestore
        .collection('students')
        .orderBy('createdAt', descending: true)
        .get();

    int nomorTerakhir = snapshot.docs.length;

    int nomorPendaftaran = nomorTerakhir + 1;

    String imageFileName = 'student_image_$nomorPendaftaran.jpg';
    Reference ref = _storage.ref().child('student_images').child(imageFileName);
    UploadTask uploadTask = ref.putFile(File(imagePath));
    TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    String imageUrl = await downloadUrl.ref.getDownloadURL();

    await _firestore.collection('students').add({
      'namaLengkap': namaLengkap,
      'email': email,
      'namaLembaga': namaLembaga,
      'nisn': nomorPendaftaran.toString(),
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
    });
  }
}
