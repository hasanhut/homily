import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:homily/model/calendarEvent.dart';
import 'package:homily/model/group.dart';
import 'package:homily/model/user.dart';
import 'package:intl/intl.dart';

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
    List<CalendarEvent> _calendarEvents = [];
    List<String> _shoppingItem = [];

    try {
      members.add(useruid!);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name': groupName,
        'leader': useruid,
        'members': members,
        'calendarEvents': _calendarEvents,
        'shoppingLists': _shoppingItem
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

  Future<String> addCalendarEvents(String groupId, String title,
      String description, DateTime? eventDate) async {
    String retVal = "error";
    var _calendarEvent = CalendarEvent(
        title: title, description: description, eventDate: eventDate);
    var map = new Map<String, dynamic>();
    map['title'] = _calendarEvent.title;
    map['description'] = _calendarEvent.description;
    map['eventDate'] = _calendarEvent.eventDate;
    try {
      await _firestore.collection("groups").doc(groupId).update({
        'calendarEvents': FieldValue.arrayUnion([map]),
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> addShoppingList(String groupId, String item) async {
    String retVal = "error";
    var map = new Map<String, dynamic>();
    try {
      await _firestore.collection("groups").doc(groupId).update({
        'shoppingLists': FieldValue.arrayUnion([item]),
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
  /*Future<String> createCalendarEvents(CalendarEvent calendarEvent) async {
    String retVal = "error";

    try {
      await _firestore.collection("calendarEvents").doc(calendarEvent.id).set({
        "title": calendarEvent.title,
        "description": calendarEvent.description,
        "eventdate": calendarEvent
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }*/

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

  Future<List?> getCalendarEvents(String? groupId) async {
    List<dynamic>? eventList;

    try {
      final _calendarEvent = await FirebaseFirestore.instance
          .collection("groups")
          .doc(groupId)
          .get();
      eventList = _calendarEvent.data()!["calendarEvents"];
    } catch (e) {
      print(e);
    }

    return eventList;
  }

  Future<List?> getShoppingListItem(String? groupId) async {
    List<String>? shoppingList;

    try {
      final _calendarEvent = await FirebaseFirestore.instance
          .collection("groups")
          .doc(groupId)
          .get();
      shoppingList = _calendarEvent.data()!["shoppingLists"];
    } catch (e) {
      print(e);
    }

    return shoppingList;
  }

  Future<CalendarEvent> getEvent(String? groupId) async {
    CalendarEvent retVal =
        CalendarEvent(description: "", eventDate: null, title: "");

    try {
      DocumentSnapshot<Map<String, dynamic>> _docSnapshot =
          await _firestore.collection("groups").doc(groupId).get();
      retVal.title = _docSnapshot.data()!["calendarEvents"][0]["title"];
      retVal.description =
          _docSnapshot.data()!["calendarEvents"][0]["description"];
      retVal.eventDate = _docSnapshot.data()!["calendarEvents"][0]["eventDate"];
    } catch (e) {
      print(e);
    }
    String formatTimestamp(Timestamp timestamp) {
      var format = new DateFormat('y-MM-d'); // <- use skeleton here
      return format.format(timestamp.toDate());
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
