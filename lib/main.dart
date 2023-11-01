import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart.dart';
import 'package:flutter_application_1/homepages/menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Color mainColor = Color.fromRGBO(12, 97, 86, 1);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Menu(),
    );
  }
}
