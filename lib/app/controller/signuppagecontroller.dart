import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:testlatisedu/app/data/authenticationrepository.dart';
import 'package:testlatisedu/app/data/userrepository.dart';
import 'package:testlatisedu/app/helper/firebaseerror.dart';
import 'package:testlatisedu/app/model/usermodel.dart';

class SignUpPageController extends GetxController {
  static SignUpPageController get instance => Get.find();

  final namaEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPassEditingController = TextEditingController();
  final phoneNumberEditingController = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  RxBool hidePass = true.obs;
  RxBool confirmHidePass = true.obs;

  Future<void> signUp() async {
    try {
      if (!signUpFormKey.currentState!.validate()) {
        return;
      } else {
        openDialig();
        final userCredential = await AuthenticationRepository.instance
            .registerWithEmailAndPassword(emailEditingController.text.trim(),
                passwordEditingController.text.trim());
        final newUser = UserModel(
          id: userCredential.user!.uid,
          namaLengkap: namaEditingController.text,
          email: emailEditingController.text.trim(),
          noTelfon: phoneNumberEditingController.text.trim(),
        );
        final userRepository = Get.put(UserRepository());
        await userRepository.saveUserData(newUser);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-exists') {
        AuthErrorHandling.emailAlreadyExist();
      }
    } finally {
      AuthenticationRepository.instance.pindahHalaman();
    }
  }

  void openDialig() {
    Get.dialog(
        Dialog(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const SizedBox(
            width: 100,
            height: 150,
            child: SpinKitCubeGrid(
              size: 100,
              color: Colors.white,
            ),
          ),
        ),
        barrierDismissible: false);
  }
}
