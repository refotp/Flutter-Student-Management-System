import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;

class SiswaPageController extends GetxController {
  RxList<DocumentSnapshot> students = <DocumentSnapshot>[].obs;
  RxBool isSearch = false.obs;
  @override
  void onInit() {
    fetchStudents();
    super.onInit();
  }

  Future<void> generatePDF(
    BuildContext context,
    List<DocumentSnapshot> studentsData,
  ) async {
    final pdf = pw.Document();
    final List<Future<http.Response>> imageFutures =
        studentsData.map((student) {
      return http.get(Uri.parse(student['imageUrl']));
    }).toList();

    final List<http.Response> images = await Future.wait(imageFutures);

    const int studentsPerPage = 3;

    for (int i = 0; i < studentsData.length; i += studentsPerPage) {
      final List<DocumentSnapshot> pageStudents = studentsData.sublist(
        i,
        i + studentsPerPage < studentsData.length
            ? i + studentsPerPage
            : studentsData.length,
      );

      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Column(
              children: pageStudents.asMap().entries.map((entry) {
                final int index = entry.key;
                final DocumentSnapshot student = entry.value;
                final http.Response imageResponse = images[index];

                if (imageResponse.statusCode == 200) {
                  return pw.Container(
                    margin: const pw.EdgeInsets.all(16),
                    padding: const pw.EdgeInsets.all(16),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Image(
                          pw.MemoryImage(imageResponse.bodyBytes),
                          width: 50,
                          height: 50,
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text('NISN: ${student['nisn']}'),
                        pw.SizedBox(height: 8),
                        pw.Text('Nama Siswa: ${student['namaLengkap']}'),
                        pw.SizedBox(height: 8),
                        pw.Text('Nama Lembaga: ${student['namaLembaga']}'),
                        pw.SizedBox(height: 8),
                        pw.Text('Email: ${student['email']}'),
                        pw.SizedBox(height: 16),
                      ],
                    ),
                  );
                } else {
                  return pw.Container(
                    margin: const pw.EdgeInsets.all(16),
                    padding: const pw.EdgeInsets.all(16),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.grey),
                      borderRadius: pw.BorderRadius.circular(8),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          width: 100,
                          height: 100,
                          color: PdfColors.grey,
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text('NISN: ${student['nisn']}'),
                        pw.SizedBox(height: 8),
                        pw.Text('Nama Siswa: ${student['namaLengkap']}'),
                        pw.SizedBox(height: 8),
                        pw.Text('Nama Lembaga: ${student['namaLembaga']}'),
                        pw.SizedBox(height: 8),
                        pw.Text('Email: ${student['email']}'),
                        pw.SizedBox(height: 16),
                      ],
                    ),
                  );
                }
              }).toList(),
            );
          },
        ),
      );
    }

    final output = await getTemporaryDirectory();
    final file = File("${output.path}/daftar_siswa.pdf");
    await file.writeAsBytes(await pdf.save());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('PDF telah disimpan'),
          content: Text('PDF telah disimpan di ${file.path}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Open the saved PDF file
                OpenFilex.open(file.path);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void searchStudents(String query) {
    students.assignAll(students
        .where((student) =>
            student['namaLengkap']
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            student['namaLembaga'].toLowerCase().contains(query.toLowerCase()))
        .toList());
    isSearch.value = true;
  }

  void fetchStudents() {
    FirebaseFirestore.instance
        .collection('Students')
        .orderBy('nisn', descending: true)
        .snapshots()
        .listen((snapshot) {
      students.assignAll(snapshot.docs);
    });
    isSearch.value = false;
  }
}
