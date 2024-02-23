import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:testlatisedu/app/controller/siswapagecontroller.dart';
import 'package:testlatisedu/app/editstudent/editstudentpage.dart';
import 'package:testlatisedu/app/screens/addstudents/addstudentpage.dart';

class SiswaPage extends StatelessWidget {
  const SiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SiswaPageController();
    controller.onInit();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('students')
              .orderBy('nisn', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('Tidak ada data siswa.'),
              );
            }

            return Column(children: [
              TextField(
                onChanged: (query) {
                  if (query.trim().isNotEmpty) {
                    controller.searchStudents(query);
                  } else {
                    controller.fetchStudents();
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Search by name...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Daftar siswa',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Expanded(child: Obx(() {
                if (controller.students.isEmpty) {
                  return Center(
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
                      margin: EdgeInsets.all(10),
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
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    studentData['namaLengkap'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 4),
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
                                          print(studentData.data());
                                          Get.to(EditStudentPage(
                                            studentData: studentData,
                                          ));
                                        },
                                        child: Text('Edit')),
                                    TextButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('students')
                                              .doc(studentData.id)
                                              .delete()
                                              .then((_) {
                                            print(
                                                'Data siswa berhasil dihapus');
                                          }).catchError((error) {
                                            print(
                                                'Error saat menghapus data siswa: $error');
                                          });
                                        },
                                        child: Text('Delete')),
                                  ],
                                ),
                                SizedBox(height: 8),
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
