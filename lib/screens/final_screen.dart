import 'package:flutter/material.dart';

class FianlScreen extends StatefulWidget {
  @override
  State<FianlScreen> createState() => _FianlScreenState();
}

class _FianlScreenState extends State<FianlScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.all(20),
          child: Center(
            child: Text(
              'Your have fully completed the submission process please wait for the results, Thank you !',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ),
    );
  }
}
