import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homily/screens/expense_tracker/expense_tracker_homepage.dart';
import 'package:homily/screens/login.dart';
import 'package:homily/screens/photo_album/photo_album_home.dart';
import 'package:homily/screens/profile.dart';
import 'package:homily/service/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final FirebaseAuth auth = FirebaseAuth.instance;

void inputData() {
  final user = auth.currentUser;
  final uid = user?.uid;
}

class _HomePageState extends State<HomePage> {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text('H O M I L Y'),
          backgroundColor: Colors.black,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Show Snackbar',
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                ),
              },
            ),
          ]),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => {},
                child: const Text("Calendar"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Text("Shopping List"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpenseTrackerHomePage()),
                  ),
                },
                child: const Text("Expense Tracker"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Text("Task Sharer"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: const Text("Event Planner"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PhotoAlbumHome()),
                  ),
                },
                child: const Text("Photo Album"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
              ),
              ElevatedButton(
                onPressed: () => {
                  inputData(),
                  _authService.signOut(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  ),
                },
                child: const Text("Sign Out"),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black54),
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    minimumSize: MaterialStateProperty.all(
                        const Size(300, 50)) //Button Background Color
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
