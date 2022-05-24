import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:homily/screens/root/root.dart';
import 'package:homily/service/currentUser.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Home Page',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: OurRoot()),
    );
  }
}
