import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testlatisedu/app/screens/signup/signuppage.dart';

class BottomSection extends StatelessWidget {
  const BottomSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Belum punya akun ?'),
            ElevatedButton(
              style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0),
                  backgroundColor: const MaterialStatePropertyAll(
                      Color.fromARGB(255, 210, 160, 9)),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  )),
              onPressed: () {
                Get.to(() => const SignUpPage());
              },
              child: const Text(
                'Buat Akun',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Dengan ini anda telah menyetujui syarat dan kebijakan perusahaan kami',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
