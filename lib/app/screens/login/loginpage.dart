import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:testlatisedu/app/controller/loginpagecontroller.dart';
import 'package:testlatisedu/app/helper/validator.dart';
import 'package:testlatisedu/app/screens/login/bottomsection.dart';
import 'package:testlatisedu/app/screens/login/formspacing.dart';
import 'package:testlatisedu/app/screens/login/headersection.dart';
import 'package:testlatisedu/app/widgets/stylewidget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginPageController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderSection(
                title: 'Login',
                subtitle:
                    'Temukanlah berita tanpa batas dengan sumber terpercaya',
              ),
              const FormSpacing(),
              Form(
                key: controller.loginFormKey,
                child: Column(
                  children: [
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
                          controller: controller.emailController,
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
                            controller: controller.passwordController,
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
                                    : const Icon(Iconsax.eye),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                    const FormSpacing(),
                    const BottomSection(),
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
                  style: buttonFormStyle(Colors.blue),
                  onPressed: () {
                    controller.logIn();
                  },
                  child: Text(
                    'Login',
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
