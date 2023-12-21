import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;

class User {
  String id;

  String password;
  String name;
  List milestone;
  bool isStarted;
  Timestamp? timestamp;
  Timestamp? timestampFinal;
  int? sec;

  User(
      {required this.id,
      required this.password,
      required this.name,
      required this.milestone,
      required this.isStarted,
      this.timestamp,
      this.timestampFinal,
      this.sec});
}

class Users with ChangeNotifier {
  Future<bool> pointAdder(String id, double points, context) async {
    try {
      // Get a reference to the user's document in Firestore
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(id);

      // Update the milestone field by incrementing the provided points
      await userRef.update({'milestone': FieldValue.increment(points)});

      print('Milestone updated successfully.');
      Navigator.of(context).pop();
      return true;
    } catch (error) {
      print('Error updating milestone: $error');
      Navigator.of(context).pop();
      return false;
    }
  }

  Future<bool> addUserToFirestore(User newUser) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(newUser.id).set({
        'id': newUser.id,
        'password': newUser.password,
        'name': newUser.name,
        'milestone': newUser.milestone,
        'isStarted': newUser.isStarted,
      });

      notifyListeners();
      return true;
    } catch (error) {
      print(error);
      Fluttertoast.showToast(
          msg: "${error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          textColor: Color.fromARGB(255, 0, 0, 0),
          fontSize: 16.0);
      return false;
      // rethrow;
    }
  }

  Future<User?> fetchUserFromFirestore(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      print('hello ');
      // print(snapshot);

      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        final user = User(
          id: userData['id'],
          password: userData['password'],
          name: userData['name'],
          milestone: userData['milestone'],
          isStarted: userData['isStarted'],
        );

        return user;
      } else {
        Fluttertoast.showToast(
            msg: "NOT FOUND",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            textColor: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16.0);
        return null;
      }
    } catch (error) {
      print('hereherehehrehrherhehr');
      Fluttertoast.showToast(
          msg: "${error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          textColor: Color.fromARGB(255, 0, 0, 0),
          fontSize: 16.0);
      print(error);
      return null;
    }
  }

  Future<User?> fetchUserFromFirestoreForidTinitalTfinal(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      print('hello ');
      // print(snapshot);

      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        final user = User(
          id: userData['id'],
          password: userData['password'],
          name: userData['name'],
          milestone: userData['milestone'],
          isStarted: userData['isStarted'],
          timestamp: userData['timestamp'],
          timestampFinal: userData['timestampFinal'],
          sec: userData['sec'],
        );

        return user;
      } else {
        Fluttertoast.showToast(
            msg: "NOT FOUND",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            textColor: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16.0);
        return null;
      }
    } catch (error) {
      print('hereherehehrehrherhehr');
      Fluttertoast.showToast(
          msg: "${error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          textColor: Color.fromARGB(255, 0, 0, 0),
          fontSize: 16.0);
      print(error);
      return null;
    }
  }

  Future<String?> fetchCodeFromFirestore() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('code') // Change to 'code' collection
          .doc('code') // Change to 'code' document
          .get();

      if (snapshot.exists) {
        final codeData = snapshot.data() as Map<String, dynamic>;
        final code = codeData[
            'code']; // Replace with the actual field name where your code is stored
        print(code);
        print('gonzalo chaddi');
        return code;
      } else {
        Fluttertoast.showToast(
            msg: "Code not found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            textColor: Color.fromARGB(255, 0, 0, 0),
            fontSize: 16.0);
        return null;
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: "${error}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          textColor: Color.fromARGB(255, 0, 0, 0),
          fontSize: 16.0);
      print(error);
      return null;
    }
  }
}









// usage 
// Add a new user
// User newUser = User(id: 'exampleId', password: 'examplePassword', name: 'John Doe', milestone: 5);
// await events.addUserToFirestore(newUser);

// // Fetch a user
// String userIdToFetch = 'exampleId';
// User? fetchedUser = await events.fetchUserFromFirestore(userIdToFetch);

// if (fetchedUser != null) {
//   // User found
//   print('User found: ${fetchedUser.name}');
// } else {
//   // User not found
//   print('User not found.');
// }
