import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testlatisedu/app/data/authenticationrepository.dart';
import 'package:testlatisedu/app/myapp.dart';
import 'package:testlatisedu/firebase_options.dart';

void main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));
  await FirebaseAppCheck.instance
      .activate(androidProvider: AndroidProvider.playIntegrity);
  await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  FirebaseAppCheck.instance.onTokenChange.listen((token) {
    print(token);
  });
  runApp(const MyApp());
}
