import 'package:flutter/material.dart';
import 'package:homily/screens/root/root.dart';
import 'package:homily/service/currentUser.dart';
import 'package:homily/service/database.dart';
import 'package:provider/provider.dart';

class OurCreateGroup extends StatefulWidget {
  @override
  _OurCreateGroupState createState() => _OurCreateGroupState();
}

class _OurCreateGroupState extends State<OurCreateGroup> {
  void _createGroup(BuildContext context, String groupName) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await OurDatabase()
        .createGroup(groupName, _currentUser.getCurrentUser.uid);
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  TextEditingController _groupNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('H O M I L Y'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Name",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _createGroup(context, _groupNameController.text),
                    child: Text("Create Group"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black54),
                        overlayColor: MaterialStateProperty.all(Colors.grey),
                        minimumSize: MaterialStateProperty.all(
                            const Size(300, 50)) //Button Background Color
                        ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
