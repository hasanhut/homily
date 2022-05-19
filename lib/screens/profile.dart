import 'package:flutter/material.dart';
import 'package:homily/screens/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userId = '';
  String username = '';
  String userEmail = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H O M I L Y'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Text("Loading data....");
            }
            return Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  //backgroundImage: ,
                ),
                Text(
                  'Username : $username',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Email : $userEmail',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Family Name : ------',
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(firebaseUser.uid)
          .get()
          .then((value) => {
                userEmail = value.data()!["email"],
                username = value.data()!["username"],
                userId = firebaseUser.uid.toString()
              });
    }
  }
}
