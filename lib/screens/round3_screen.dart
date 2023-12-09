import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:initator/screens/qr_scanner_screen.dart';
import 'package:initator/widgets/timer_widget.dart';

import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Round3 extends StatefulWidget {
  late String id;
  Round3(this.id);
  @override
  _Round3State createState() => _Round3State();
}

class _Round3State extends State<Round3> {
  late String id;
  late int reqNum;
  late int currenRandomQuestionIndex;

  late DateTime startTime;

  late FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    id = widget.id;
    reqNum = int.parse(id);
    reqNum = reqNum % 10;
    if (reqNum >= 5) {
      reqNum = reqNum - 5;
    }

    currenRandomQuestionIndex = reqNum;
    startTime = DateTime.now();
    super.initState();
    // here set the time of the start time of the round for this question
  }

  Widget toast(bool val) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color.fromARGB(255, 182, 222, 255),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          val == false ? Icon(Icons.warning) : Icon(Icons.fireplace),
          SizedBox(
            width: 12.0,
          ),
          Text(
              val == false ? "  Wrong Answer !    " : "  Correct Answer !    "),
        ],
      ),
    );
  }

  int calculateElapsedTime() {
    Duration elapsed = DateTime.now().difference(startTime);
    return elapsed.inSeconds;
  }

  List<String> questions = [
    'To unveil the next treasure, seek the realm where algorithms dance and codes weave; where circuits hum with the melody of innovation. Your quest leads to the heart of our academic hub, where bytes and dreams collide. ',
    'Follow the path where blueprints come to life, where structures soar and foundations thrive, seek the next hint where engineers strive.',
    'Seek the hidden knowledge where waves converge, where signals dance through the air. Find the place where bytes whisper and frequencies embrace, unlocking the gateway to the secrets of connectivity.',
    'Seek the hidden trove where cogs dance in unison, echoing the precision of nature\'s clock, where wisdom whispers through metallic veins beneath the green canopy of academia.',
    'Seek the hidden prize where echoes of laughter and splashes fill the air, a place where liquid joy mirrors the sky\'s hue',
  ];

  List<String> answers = [
    'cse',
    'civil',
    'ece',
    'mechanical',
    'swimming pool',
  ];

  void _openBottomSheet(BuildContext context, int index, int seconds) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: CountdownTimer(seconds, answers[index]),
            ),
          ],
        );
      },
    );
  }

  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    void checkAnswer(String ansByUser, int currenRandomQuestionIndex,
        BuildContext context) async {
      if (ansByUser.toLowerCase().replaceAll(' ', '') ==
          answers[currenRandomQuestionIndex]
              .toLowerCase()
              .replaceAll(' ', '')) {
        print(ansByUser);
        print(currenRandomQuestionIndex);
        print('Correct answer ');

        var toastWidget = toast(true);
        fToast.showToast(
          child: toastWidget,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 1),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                QrScannerPageFor1(answers[currenRandomQuestionIndex], id, 1),
          ),
        );
      } else {
        var toastWidget = toast(false);
        fToast.showToast(
          child: toastWidget,
          gravity: ToastGravity.BOTTOM,
          toastDuration: Duration(seconds: 1),
        );

        print('Wrong answer!');
      }
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Round 3 ',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 182, 222, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(right: 20, top: 10),
              child: TextButton(
                onPressed: () {
                  int elapsedTime = calculateElapsedTime();
                  _openBottomSheet(
                      context, currenRandomQuestionIndex, elapsedTime);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min, // Align items in a row
                  children: [
                    Text(
                      " Hint",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.lightbulb,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  margin: EdgeInsets.only(left: 7, right: 5),
                  child: Text(
                    questions[currenRandomQuestionIndex],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Enter your answer',
                      ),
                    ),
                  ),
                ),
                Container(
                  // height: 60,
                  margin: EdgeInsets.all(10),

                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 182, 222, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                  child: TextButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      checkAnswer(_textController.text,
                          currenRandomQuestionIndex, context);

                      // go to the qr code scanning page
                    },
                    child: const Text(
                      'Next',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ), //add some styles
                  ),
                ),
                // QrImageView(
                //   data: '1234567890',
                //   version: QrVersions.auto,
                //   size: 200.0,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
