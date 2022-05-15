import 'package:flutter/material.dart';
import 'package:homily/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Photo Album',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomePage());
  }
}
