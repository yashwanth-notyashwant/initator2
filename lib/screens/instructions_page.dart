import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:initator/screens/round1_screen.dart';
import 'package:initator/screens/round3_screen.dart';
import 'package:initator/screens/round2_screen.dart';
import 'package:initator/screens/round5_screen.dart';
import 'package:initator/screens/round6_screen.dart';
import 'package:initator/screens/round8_screen.dart';

// ignore: must_be_immutable
class InstructionsScreen extends StatefulWidget {
  late String id;
  InstructionsScreen(this.id);
  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  final List<String> chapters = [
    " Instructions ",
  ];

  final List<String> texts = [
    """ 

Example of Variable in Python

dummy data 
An Example of a Variable in Python is a representational name that serves as a pointer to an object. Once an object is assigned to a variable, it can be referred to by that name. In layman’s terms, we can say that Variable in Python is containers that store values.

Here we have stored “Geeksforgeeks”  in a var which is variable, and when we call its name the stored information will get printed.

Var = "Geeksforgeeks"
print(Var)

Rules for Python variables
A Python variable name must start with a letter or the underscore character.
A Python variable name cannot start with a number.
A Python variable name can only contain alpha-numeric characters and underscores (A-z, 0-9, and _ ).
Variable in Python names are case-sensitive (name, Name, and NAME are three different variables).
The reserved words(keywords) in Python cannot be used to name the variable in Python.

# valid variable name
geeks = 1
Geeks = 2
Ge_e_ks = 5
_geeks = 6
geeks_ = 7
_GEEKS_ = 8
 
print(geeks, Geeks, Ge_e_ks)
print(_geeks, geeks_, _GEEKS_)

 

""",
  ];

  Future<bool> pointAdder(String id) async {
    try {
      // mark the list [0,0,0,0,0,0,0,0] to -- > [1,0,0,0,0,0,0,0]
      // Get a reference to the user's document in Firestore
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(id);
      Timestamp timestamp = Timestamp.now();

      await userRef.update({
        'isStarted': true,
        'timestamp': timestamp,
      });

      print('Milestone updated successfully.');

      return true;
    } catch (error) {
      print('Error updating milestone: $error');

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 182, 222, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(right: 20, top: 10),
              child: TextButton(
                onPressed: () async {
                  await pointAdder(widget.id);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        // builder: (context) => Round2(widget.id)),
                        builder: (context) => Round1(widget.id)),
                    // builder: (context) => QrScanRound(widget.id)),
                  );
                },
                child: Text(
                  " Start >>",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            width: wi,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 30),
                  child: Text(
                    '${chapters[0]}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                  child: Text(
                    texts[0],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
