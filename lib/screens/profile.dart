import 'package:flutter/material.dart';
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
      backgroundColor: Colors.white,
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
            return Stack(
              children: [
                Container(
                  color: Colors.white,
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 250, left: 20, right: 20),
                ),
                Container(
                  height: 180,
                  color: Colors.white,
                ),
                Container(
                  width: double.infinity,
                  height: 190,
                  margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xfff6f6f6f),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Color.fromARGB(90, 20, 20, 20),
                          blurRadius: 0.8,
                          offset: Offset(9, 9))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 45,
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 42, //backgroundImage: ,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '$username',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        '$userEmail',
                        style: TextStyle(color: Colors.grey[800]),
                      ),
                    ],
                  ),
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
