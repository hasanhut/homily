import 'package:flutter/material.dart';
import 'package:homily/screens/group/createGroup.dart';
import 'package:homily/screens/group/joinGroup.dart';
import 'package:homily/screens/root/root.dart';
import 'package:provider/provider.dart';

import '../../service/currentUser.dart';
import '../login/login.dart';

class OurNoGroup extends StatelessWidget {
  const OurNoGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _goToJoin(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OurJoinGroup()));
    }

    void _goToCreate(BuildContext context) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OurCreateGroup()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('H O M I L Y'),
        backgroundColor: Colors.black,
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(25.0),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            "Welcome To Group Menu",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.grey[600],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(50.0),
        ),
        ElevatedButton(
          onPressed: () => _goToCreate(context),
          child: Text("Create Group"),
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
          onPressed: () => _goToJoin(context),
          child: Text("Join Group"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black54),
              overlayColor: MaterialStateProperty.all(Colors.grey),
              minimumSize: MaterialStateProperty.all(
                  const Size(300, 50)) //Button Background Color
              ),
        ),
        ElevatedButton(
          onPressed: () async {
            CurrentUser _currentUser =
                Provider.of<CurrentUser>(context, listen: false);
            String _returnString = await _currentUser.signOut();
            if (_returnString == "success") {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => OurRoot()),
                  (route) => false);
            }
          },
          child: Text("Login"),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black54),
              overlayColor: MaterialStateProperty.all(Colors.grey),
              minimumSize: MaterialStateProperty.all(
                  const Size(300, 50)) //Button Background Color
              ),
        ),
      ]),
    );
  }
}
