import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<int> getNextNisn() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Students')
        .orderBy('nisn', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      int lastNisn = querySnapshot.docs.first['nisn'];
      return lastNisn + 1;
    } else {
      return 1;
    }
  }

  Future<void> saveStudentData(String namaLengkap, String email,
      String namaLembaga, String imagePath) async {
    int nomorInduk = await getNextNisn();
    int nomorPendaftaran = nomorInduk;

    String imageFileName = 'student_image_$nomorPendaftaran.jpg';
    Reference ref = _storage.ref().child('student_images').child(imageFileName);
    UploadTask uploadTask = ref.putFile(File(imagePath));
    TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    String imageUrl = await downloadUrl.ref.getDownloadURL();

    await _firestore.collection('Students').add({
      'namaLengkap': namaLengkap,
      'email': email,
      'namaLembaga': namaLembaga,
      'nisn': nomorPendaftaran,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.now(),
    });
  }
}
