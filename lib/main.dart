import 'package:flutter/material.dart';
import 'package:homily/screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homily/screens/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Home Page',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: LoginPage());
  }
}
