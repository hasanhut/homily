import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homily/model/group.dart';
import 'package:homily/model/user.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await _firestore
          .collection("users")
          .doc(user.uid)
          .set({"name": user.name, "email": user.email});
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser?> getUserInfo(String uid) async {
    OurUser retVal = OurUser(uid: "", name: "", email: "", groupId: "");

    try {
      DocumentSnapshot<Map<String, dynamic>> _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      retVal.name = _docSnapshot.data()!["name"];
      retVal.email = _docSnapshot.data()!["email"];
      retVal.groupId = _docSnapshot.data()!["groupId"];
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> createGroup(String groupName, String? useruid) async {
    String retVal = "error";
    List<String> members = [];

    try {
      members.add(useruid!);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name': groupName,
        'leader': useruid,
        'members': members,
      });

      await _firestore
          .collection("users")
          .doc(useruid)
          .update({'groupId': _docRef.id});

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> joinGroup(String? groupId, String? useruid) async {
    String retVal = "error";
    List<String> members = [];
    try {
      members.add(useruid!);
      await _firestore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });
      await _firestore
          .collection("users")
          .doc(useruid)
          .update({'groupId': groupId});
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurGroup> getGroupInfo(String groupId) async {
    OurGroup retVal = OurGroup(id: "", name: "", leader: "", members: null);

    try {
      DocumentSnapshot<Map<String, dynamic>> _docSnapshot =
          await _firestore.collection("groups").doc(groupId).get();
      retVal.id = groupId;
      retVal.name = _docSnapshot.data()!["name"];
      retVal.leader = _docSnapshot.data()!["leader"];
      retVal.members = List<String>.from(_docSnapshot.data()!["members"]);
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
