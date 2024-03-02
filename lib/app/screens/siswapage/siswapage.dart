import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:testlatisedu/app/controller/siswapagecontroller.dart';
import 'package:testlatisedu/app/editstudent/editstudentpage.dart';
import 'package:testlatisedu/app/screens/addstudents/addstudentpage.dart';
import 'package:testlatisedu/app/widgets/stylewidget.dart';

class SiswaPage extends StatelessWidget {
  const SiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SiswaPageController();
    controller.onInit();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Students')
              .orderBy('nisn', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/Animation - 1708943744059.json',
                      frameRate: const FrameRate(29.99)),
                  Text('Tidak ada data siswa',
                      style: globalSubTitle(18, Colors.black))
                ],
              );
            }

            return Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: TextField(
                  onChanged: (query) {
                    if (query.trim().isNotEmpty) {
                      controller.searchStudents(query);
                    } else {
                      controller.fetchStudents();
                    }
                  },
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(
                      Iconsax.search_normal,
                      color: Color.fromARGB(255, 192, 115, 0),
                    ),
                    hintText: 'Nama siswa atau jenis kelas',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Daftar siswa',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                      icon: const Icon(Iconsax.document_download),
                      onPressed: () {
                        controller.generatePDF(context, controller.students);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(child: Obx(() {
                if (controller.students.isEmpty) {
                  return const Center(
                    child: Text('No students found.'),
                  );
                }
                return ListView.builder(
                  itemCount: controller.students.length,
                  itemBuilder: (context, index) {
                    var studentData = controller.students[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: NetworkImage(studentData['imageUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    studentData['namaLengkap'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis),
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    studentData['namaLembaga'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'NISN: ${studentData['nisn']}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.to(() => EditStudentPage(
                                                studentData: studentData,
                                              ));
                                        },
                                        child: const Text('Edit')),
                                    TextButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('Students')
                                              .doc(studentData.id)
                                              .delete()
                                              .then((_) {})
                                              .catchError((error) {});
                                        },
                                        child: const Text('Delete')),
                                  ],
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              })),
            ]);
          }),
      floatingActionButton: IconButton.filled(
        style:
            const ButtonStyle(iconSize: MaterialStatePropertyAll<double>(40)),
        onPressed: () {
          Get.to(() => const AddStudentPage());
        },
        icon: const Icon(Iconsax.add),
      ),
    );
  }
}
