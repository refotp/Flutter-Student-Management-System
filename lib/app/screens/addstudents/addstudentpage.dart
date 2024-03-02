import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:testlatisedu/app/controller/addstudentpagecontroller.dart';
import 'package:testlatisedu/app/helper/validator.dart';
import 'package:testlatisedu/app/screens/addstudents/imagebutton.dart';
import 'package:testlatisedu/app/screens/addstudents/submitbutton.dart';
import 'package:testlatisedu/app/screens/login/formspacing.dart';
import 'package:testlatisedu/app/widgets/stylewidget.dart';

class AddStudentPage extends StatelessWidget {
  const AddStudentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddStudentPageController();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange[800],
        title: const Text(
          'Tambah Data Siswa',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Formulir data siswa',
                    style: TextStyle(
                        fontSize: 24.spMin, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nama Lengkap',
                          style: globalSubTitle(14, Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) => Validator.validateEmptyText(
                              'Nama lengkap', value),
                          controller: controller.namaLengkap,
                          cursorColor: Colors.amber,
                          decoration: InputDecoration(
                              constraints: textFormFieldBoxContstraints(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              label: const Text('Nama Lengkap'),
                              border: textFormFieldBorder(),
                              focusedBorder: textFormFieldFocusedBorder(),
                              enabledBorder: textFormFieldEnabledBorder(),
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(131, 33, 149, 243)),
                              prefixIcon: const Icon(Iconsax.user),
                              prefixIconColor: Colors.black),
                        ),
                        const FormSpacing(),
                        Text(
                          'Email',
                          style: globalSubTitle(14, Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) =>
                              Validator.validateEmptyText('Email', value),
                          controller: controller.email,
                          cursorColor: Colors.amber,
                          decoration: InputDecoration(
                              constraints: textFormFieldBoxContstraints(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              label: const Text('Email'),
                              border: textFormFieldBorder(),
                              focusedBorder: textFormFieldFocusedBorder(),
                              enabledBorder: textFormFieldEnabledBorder(),
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(131, 33, 149, 243)),
                              prefixIcon: const Icon(Iconsax.sms),
                              prefixIconColor: Colors.black),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Row(
                          children: [
                            DropdownMenu(
                              onSelected: (value) {
                                controller.namaLembaga.value = value!;
                              },
                              width: 365.w,
                              menuStyle: const MenuStyle(
                                  surfaceTintColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              label: Text(
                                'Jenis kelas',
                                style: globalSubTitle(14, Colors.black),
                              ),
                              dropdownMenuEntries: const <DropdownMenuEntry<
                                  String>>[
                                DropdownMenuEntry(
                                    value: 'Reguler', label: 'Reguler'),
                                DropdownMenuEntry(
                                    value: 'Internasional',
                                    label: 'Internasional'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Pilih Foto',
              style: globalSubTitle(16, Colors.black),
            ),
            const FormSpacing(),
            Container(
                width: 200,
                height: 200,
                color: Colors.black,
                child: Obx(() => controller.pickedFile.value == null
                    ? Image.asset(
                        'assets/e9fe822242176fae86a863e0d5228c4a.jpg',
                      )
                    : Image.file(
                        File(controller.imageFile!.path),
                        fit: BoxFit.fitWidth,
                      ))),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () async {
                        await controller.captureImageFromCamera();
                      },
                      child: const ImageButton(
                        text: 'Kamera',
                        icon: Iconsax.camera,
                      )),
                  GestureDetector(
                    onTap: () async {
                      await controller.pickImageFromGallery();
                    },
                    child: const ImageButton(
                        text: 'Galeri', icon: Iconsax.gallery),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () {
                  controller.saveStudentData();
                },
                child: const SubmitButton(text: 'Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
