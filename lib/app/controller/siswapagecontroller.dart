import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SiswaPageController extends GetxController {
  RxList<DocumentSnapshot> students = <DocumentSnapshot>[].obs;

  @override
  void onInit() {
    // Panggil fungsi fetchStudents pada saat inisialisasi controller
    fetchStudents();
    super.onInit();
  }

  void searchStudents(String query) {
    students.assignAll(students
        .where((student) =>
            student['namaLengkap'].toLowerCase().contains(query.toLowerCase()))
        .toList());
  }

  void fetchStudents() {
    FirebaseFirestore.instance
        .collection('students')
        .orderBy('nisn', descending: true)
        .snapshots()
        .listen((snapshot) {
      students.assignAll(snapshot.docs);
    });
  }
}
