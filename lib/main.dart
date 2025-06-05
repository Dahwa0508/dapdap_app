import 'package:basicprojectlab_1/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'env/env.dart';

class OpenAI {
  static late String apiKey;
}

void main() async {
  OpenAI.apiKey = Env.apiKey;
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
