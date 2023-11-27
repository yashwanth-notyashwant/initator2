import 'dart:async';
import 'package:flutter/material.dart';

class TimerForNoHintQuestion extends StatefulWidget {
  late int seconds;
  late int roundDuration;

  TimerForNoHintQuestion(this.seconds, this.roundDuration);

  @override
  _TimerForNoHintQuestionState createState() => _TimerForNoHintQuestionState();
}

class _TimerForNoHintQuestionState extends State<TimerForNoHintQuestion> {
  late Timer _timer;
  late int _secondsRemaining;

  @override
  void initState() {
    super.initState();

    _secondsRemaining = widget.roundDuration - widget.seconds;

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
          margin: EdgeInsets.only(left: 20, right: 10, top: 25),
          child: Text(
            'Please submit you answers within: $minutes: ${seconds.toString().padLeft(2, '0')}',

            // questions[currenRandomQuestionIndex],
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 30),
        Container(
          margin: EdgeInsets.only(left: 20, top: 20, right: 10),
          // color: const Color.fromARGB(255, 255, 247, 247),
          child: Text(
            "Your answers will only be recoreded if these questions are submitted within the given duration, failing to do so might lead to incorrect result calculations ",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
