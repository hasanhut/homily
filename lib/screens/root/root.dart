import 'package:flutter/material.dart';
import 'package:homily/screens/group/noGroup.dart';
import 'package:homily/screens/homepage.dart';
import 'package:homily/screens/login/login.dart';
import 'package:homily/service/currentUser.dart';
import 'package:provider/provider.dart';

import '../splashScreen/splashScreen.dart';

enum AuthStatus { notLoggedIn, unknown, notInGroup, inGroup }

class OurRoot extends StatefulWidget {
  const OurRoot({Key? key}) : super(key: key);

  @override
  State<OurRoot> createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if (_returnString == "success") {
      if (_currentUser.getCurrentUser.groupId != "" &&
          _currentUser.getCurrentUser.groupId != null) {
        setState(() {
          _authStatus = AuthStatus.inGroup;
        });
      } else {
        setState(() {
          _authStatus = AuthStatus.notInGroup;
        });
      }
    } else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    late Widget retVal;

    switch (_authStatus) {
      case AuthStatus.unknown:
        retVal = OurSplashScreen();
        break;
      case AuthStatus.notInGroup:
        retVal = OurNoGroup();
        break;
      case AuthStatus.notLoggedIn:
        retVal = LoginPage();
        break;
      case AuthStatus.inGroup:
        retVal = HomePage();
        break;
      default:
    }
    return retVal;
  }
}
