import 'package:flutter/material.dart';
import 'package:initator/widgets/timer_widget.dart';
import 'dart:math';
import 'dart:async';

class QrScanRound extends StatefulWidget {
  // int score;
  // String id;
  // QuizPageConditionals(this.score, this.id);
  @override
  _QrScanRoundState createState() => _QrScanRoundState();
}

class _QrScanRoundState extends State<QrScanRound> {
  Random random = Random();
  late int currenRandomQuestionIndex;

  late DateTime startTime;

  @override
  void initState() {
    super.initState();
    currenRandomQuestionIndex =
        random.nextInt(5); // Initialize inside initState
    startTime = DateTime.now();
  }

  int calculateElapsedTime() {
    Duration elapsed = DateTime.now().difference(startTime);
    return elapsed.inSeconds;
  }

  List<String> questions = [
    ' What is a conditional ditional statement in Python is used to make nal ditional statement in Python is used to make decisionsnal ditional statement in Pythonnal ditional statement in P isnal ditional statement in P usednal ditional statement in P tonal ditional statement in P makenal ditional statement in P  innalnal ditional statement in P ditionalnal ditional statement in P statementnal ditional statement in P innal ditional statement in P Pythonnal ditional statement in P isnal ditional statement in P used to make  your conditional statement in Python? ans 1 ',
    'What is a conditional ditional statement in Python is used to make decisions in your conditional statement in Python? ans 2 ',
    'What is a conditional ditional statement in Python is used to make decisions in your conditional statement in Python? ans 3 ',
    'What is a conditional ditional statement in Python is used to make decisions in your conditional statement in Python? ans 4 ',
    'What is a conditional ditional statement in Python is used to make decisions in your conditional statement in Python? ans 5',
  ];

  List<String> answers = [
    'one ',
    'two',
    'three',
    'four',
    'five',
  ];

  void _openBottomSheet(BuildContext context, int index, int seconds) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   margin: EdgeInsets.only(left: 20, top: 30),
            //   // color: const Color.fromARGB(255, 255, 247, 247),
            //   child: Text(
            //     'Hint : ',
            //     style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            //     textAlign: TextAlign.start,
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: CountdownTimer(seconds),
            ),
            // if timer ends then show the timer but for now show the timer

            Container(
              margin: EdgeInsets.only(left: 20, top: 50),
              // color: const Color.fromARGB(255, 255, 247, 247),
              child: Text(
                '${answers[index]}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
              ),
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
    void checkAnswer(String ansByUser, int currenRandomQuestionIndex,
        BuildContext context) async {
      if (ansByUser == answers[currenRandomQuestionIndex]) {
        print(ansByUser);
        print(currenRandomQuestionIndex);
        print('Correct answer ');

        // Handle correct answer
        // final isdone =
        //     await Provider.of<Users>(context, listen: false).incrementUserScore(
        //   widget.id,
        // );
      } else {
        // Handle wrong answer
        print('Wrong answer!');
        // _openBottomSheet(context, currenRandomQuestionIndex);
        //open the scaffold bottom sheet
      }
      // Move to the next question
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: BackButton(
        //   color: Colors.black,
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
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
                  onPressed: () => checkAnswer(
                      _textController.text, currenRandomQuestionIndex, context),
                  child: const Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ), //add some styles
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
