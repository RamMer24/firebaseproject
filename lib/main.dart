import 'package:firebaseproject/screen/ADDEMPLOYE.dart';
import 'package:firebaseproject/screen/firebasemenu.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screen/ADDPRODUCT.dart';
import 'screen/UPDATEPAGE.dart';
import 'screen/VIEWEMPLOYE.dart';
import 'screen/VIEWPRODUCT.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  firebasemenu(),
    );
  }
}

