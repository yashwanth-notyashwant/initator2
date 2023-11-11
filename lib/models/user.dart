import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:http/http.dart' as http;

class User {
  String id;

  String password;
  String name;
  int milestone;

  User({
    required this.id,
    required this.password,
    required this.name,
    required this.milestone,
  });
}

class Users with ChangeNotifier {
  Future<void> addUserToFirestore(User newUser) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(newUser.id).set({
        'id': newUser.id,
        'password': newUser.password,
        'name': newUser.name,
        'milestone': newUser.milestone,
      });

      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<User?> fetchUserFromFirestore(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      print('hello ');
      print(snapshot);

      if (snapshot.exists) {
        final userData = snapshot.data() as Map<String, dynamic>;
        final user = User(
          id: userData['id'],
          password: userData['password'],
          name: userData['name'],
          milestone: userData['milestone'],
        );

        return user;
      } else {
        return null;
      }
    } catch (error) {
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
