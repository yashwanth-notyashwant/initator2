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
        body: Center(
          child: Text(
              'Your have fully completed the submission process please wait for the results , Thank yuu'),
        ),
      ),
    );
  }
}
