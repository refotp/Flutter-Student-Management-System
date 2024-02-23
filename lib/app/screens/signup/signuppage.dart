import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:testlatisedu/app/controller/signuppagecontroller.dart';
import 'package:testlatisedu/app/helper/validator.dart';
import 'package:testlatisedu/app/screens/login/formspacing.dart';
import 'package:testlatisedu/app/screens/login/headersection.dart';
import 'package:testlatisedu/app/widgets/stylewidget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignUpPageController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(
                  title: 'Register',
                  subtitle:
                      'Daftarkan dirimu dan nikmati berita-berita terbaik yang telah kami persiapkan'),
              Form(
                key: controller.signUpFormKey,
                child: Column(
                  children: [
                    const FormSpacing(),
                    Column(
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
                          validator: (value) =>
                              Validator.validateEmptyText('Nama', value),
                          controller: controller.namaEditingController,
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
                      ],
                    ),
                    const FormSpacing(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'E-mail',
                          style: globalSubTitle(14, Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) =>
                              Validator.validateEmptyText('E-mail', value),
                          controller: controller.emailEditingController,
                          cursorColor: Colors.amber,
                          decoration: InputDecoration(
                              constraints: textFormFieldBoxContstraints(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              label: const Text('E-mail'),
                              border: textFormFieldBorder(),
                              focusedBorder: textFormFieldFocusedBorder(),
                              enabledBorder: textFormFieldEnabledBorder(),
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(131, 33, 149, 243)),
                              prefixIcon: const Icon(Iconsax.sms),
                              prefixIconColor: Colors.black),
                        ),
                      ],
                    ),
                    const FormSpacing(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: globalSubTitle(14, Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          return TextFormField(
                            validator: (value) =>
                                Validator.validateEmptyText('Password', value),
                            obscureText: controller.hidePass.value,
                            controller: controller.passwordEditingController,
                            cursorColor: Colors.amber,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                constraints: textFormFieldBoxContstraints(),
                                label: const Text('Password'),
                                border: textFormFieldBorder(),
                                focusedBorder: textFormFieldFocusedBorder(),
                                enabledBorder: textFormFieldEnabledBorder(),
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(131, 33, 149, 243)),
                                prefixIcon: const Icon(Iconsax.lock),
                                prefixIconColor: Colors.black,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.hidePass.value =
                                          !controller.hidePass.value;
                                    },
                                    icon: controller.hidePass.value
                                        ? const Icon(Iconsax.eye_slash)
                                        : const Icon(Iconsax.eye))),
                          );
                        })
                      ],
                    ),
                    const FormSpacing(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Konfirmasi Password',
                          style: globalSubTitle(14, Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          return TextFormField(
                            validator: (value) => Validator.validatePassword(
                                value,
                                controller.passwordEditingController.text),
                            obscureText: controller.confirmHidePass.value,
                            controller: controller.confirmPassEditingController,
                            cursorColor: Colors.amber,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                constraints: textFormFieldBoxContstraints(),
                                label: const Text('Password'),
                                border: textFormFieldBorder(),
                                focusedBorder: textFormFieldFocusedBorder(),
                                enabledBorder: textFormFieldEnabledBorder(),
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(131, 33, 149, 243)),
                                prefixIcon: const Icon(Iconsax.lock),
                                prefixIconColor: Colors.black,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.confirmHidePass.value =
                                          !controller.confirmHidePass.value;
                                    },
                                    icon: controller.confirmHidePass.value
                                        ? const Icon(Iconsax.eye_slash)
                                        : const Icon(Iconsax.eye))),
                          );
                        })
                      ],
                    ),
                    const FormSpacing(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nomor Telefon',
                          style: globalSubTitle(14, Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) => Validator.validateEmptyText(
                              'Nomor Telefon', value),
                          controller: controller.phoneNumberEditingController,
                          cursorColor: Colors.amber,
                          decoration: InputDecoration(
                              constraints: textFormFieldBoxContstraints(),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              label: const Text('081234567810'),
                              border: textFormFieldBorder(),
                              focusedBorder: textFormFieldFocusedBorder(),
                              enabledBorder: textFormFieldEnabledBorder(),
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(131, 33, 149, 243)),
                              prefixIcon: const Icon(Iconsax.call),
                              prefixIconColor: Colors.black),
                        ),
                      ],
                    ),
                    const FormSpacing(),
                  ],
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              SizedBox(
                width: double.maxFinite,
                height: 44.h,
                child: ElevatedButton(
                  style:
                      buttonFormStyle(const Color.fromARGB(255, 220, 168, 15)),
                  onPressed: () {
                    controller.signUp();
                  },
                  child: Text(
                    'Register',
                    style: textButton(Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
