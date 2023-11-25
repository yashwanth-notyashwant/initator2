import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  late int seconds;
  late String answer;

  CountdownTimer(this.seconds, this.answer);

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();

    _secondsRemaining = 90 - widget.seconds;

    if (_secondsRemaining <= 0) {
      _secondsRemaining = 0;
    }
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel(); // Stop the timer when it reaches 0
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5, right: 5, top: 25),
          child: Text(
            'Next hint in :$minutes: ${seconds.toString().padLeft(2, '0')}',

            // questions[currenRandomQuestionIndex],
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.only(left: 20, top: 40),
          // color: const Color.fromARGB(255, 255, 247, 247),
          child: Text(
            seconds <= 0
                ? 'Your answer is ${widget.answer}, First enter this answer and then go to this location and scan the QR Code and then submit your answer if the QR code is Correct. '
                : "Please wait till you see a 00:00 in the timer, Or till you current wait timer is finished ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
