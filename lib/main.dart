import 'package:customm/screen/first_screen.dart';
import 'package:customm/shared/constraint.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: Constraints.apikey,
          appId: Constraints.appId,
          storageBucket: Constraints.storageBucket,
          messagingSenderId: Constraints.messageSenderId,
          projectId: Constraints.projectId),);
  } else {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: Constraints.apikey,
          appId: Constraints.appId,
          storageBucket: Constraints.storageBucket,
          messagingSenderId: Constraints.messageSenderId,
          projectId: Constraints.projectId),);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstScreen(),
    );
  }
}


