import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:initator/models/user.dart';
import 'package:initator/screens/qr_scanning_round.dart';
import 'package:initator/screens/round2_screen.dart';
import 'package:initator/widgets/timer_for_round1type.dart';
import 'package:initator/widgets/timer_widget.dart';
import 'package:provider/provider.dart';
import 'package:loading_btn/loading_btn.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: must_be_immutable
class Round1Apti15m extends StatefulWidget {
  late String id;
  Round1Apti15m(this.id);
  @override
  State<Round1Apti15m> createState() => _Round1Apti15mState();
}

class _Round1Apti15mState extends State<Round1Apti15m> {
  late DateTime startTime;
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();
  final TextEditingController _textController5 = TextEditingController();
  final TextEditingController _textController6 = TextEditingController();
  final TextEditingController _textController7 = TextEditingController();
  final TextEditingController _textController8 = TextEditingController();
  final TextEditingController _textController9 = TextEditingController();
  final TextEditingController _textController10 = TextEditingController();
  int _currentIndex = 0;
  bool isSubmitted = false;

  final List<Map<String, String>> _questions = [
    {
      "question": "How many planets are in our solar system? Ans8",
      "answer": "Eight",
      "stat": "F",
    },
    {
      "question": "How many elements are there in the periodic table? Ans1",
      "answer": "One",
      "stat": "F",
    },
    {
      "question": "How many years did the Hundred Years' War last? Ans15",
      "answer": "fifteen",
      "stat": "F",
    },
    {
      "question": "How many provinces are there in Canada? Ans10",
      "answer": "Ten",
      "stat": "F",
    },
    {
      "question": "How many continents are there in the world? Ans7",
      "answer": "Seven",
      "stat": "F",
    },
    {
      "question": "How many sides does a hexagon have? Ans6",
      "answer": "Six",
      "stat": "F",
    },
    {
      "question": "How many days are there in a week? Ans7",
      "answer": "Seven",
      "stat": "F",
    },
    {
      "question": "How many states are there in Australia? Ans6",
      "answer": "Six",
      "stat": "F",
    },
    {
      "question": "How many oxygen atoms are there in a water molecule? Ans1",
      "answer": "One",
      "stat": "F",
    },
    {
      "question": "How many books are there in the Harry Potter series? Ans7",
      "answer": "Seven",
      "stat": "F",
    },
  ];

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

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();
    _textController5.dispose();
    _textController6.dispose();
    _textController7.dispose();
    _textController8.dispose();
    _textController9.dispose();
    _textController10.dispose();
    super.dispose();
  }

  late FToast fToast;

  @override
  void initState() {
    startTime = DateTime.now();
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _questions.shuffle(); // Shuffle the list of questions at the beginning
  }

  int calculateElapsedTime() {
    Duration elapsed = DateTime.now().difference(startTime);
    return elapsed.inSeconds;
  }

  void checkAnswer(
      String ansByUser, int _currentIndex, BuildContext context) async {
    if (ansByUser.toLowerCase().replaceAll(' ', '') ==
        _questions[_currentIndex]['answer']
            ?.toLowerCase()
            .replaceAll(' ', '')) {
      var toastWidget = toast(true);
      fToast.showToast(
        child: toastWidget,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 1),
      );

      setState(() {
        _questions[_currentIndex]['stat'] = 'T';
      });
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

  void _showNextQuestion() {
    if (_currentIndex == _questions.length - 1) {
      return;
    }
    setState(() {
      _currentIndex = (_currentIndex + 1) % _questions.length;
    });
  }

  void _showPreviousQuestion() {
    if (_currentIndex == 0) {
      return;
    }
    setState(() {
      _currentIndex = (_currentIndex - 1) % _questions.length;
    });
  }

  int countItemsWithTStat(List<Map<String, String>> list) {
    int count = 0;

    for (var item in list) {
      if (item["stat"] == "T") {
        count++;
      }
    }

    return count;
  }

  @override
  Widget build(BuildContext context) {
    List CpntrollerList = [
      _textController1,
      _textController2,
      _textController3,
      _textController4,
      _textController5,
      _textController6,
      _textController7,
      _textController8,
      _textController9,
      _textController10,
    ];

    Future<bool> pointAdder(String id, double points) async {
      try {
        // Get a reference to the user's document in Firestore
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(id);

        // Update the milestone field by incrementing the provided points
        await userRef.update({'milestone': FieldValue.increment(points)});

        print('Milestone updated successfully.');

        return true;
      } catch (error) {
        print('Error updating milestone: $error');

        return false;
      }
    }

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
                child: TimerForNoHintQuestion(seconds, 900),
              ),
            ],
          );
        },
      );
    }

    // var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: !isSubmitted
            ? AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.5 - 10,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 182, 222, 255),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        margin: EdgeInsets.only(top: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ), // Set the border radius here
                            ),
                          ),
                          onPressed: () {
                            _showPreviousQuestion();
                          },
                          child: const Text(
                            "<< Previous ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.5 - 10,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 182, 222, 255),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        margin: EdgeInsets.only(top: 10, right: 5),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ), // Set the border radius here
                            ),
                          ),
                          onPressed: () {
                            _showNextQuestion();
                          },
                          child: const Text(
                            " Next >>",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : AppBar(
                title: Text(''),
              ),
        body: !isSubmitted
            ? SingleChildScrollView(
                child: Container(
                  width: wi,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 30),
                        child: Text(
                          'Question no:${_currentIndex + 1}',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      _questions[_currentIndex]['stat'] == 'T'
                          ? Container(
                              // height: 60,
                              margin: EdgeInsets.only(top: 30),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 182, 222, 255),
                                // borderRadius: BorderRadius.circular(20),
                              ),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 10, right: 10),

                              child: const Text(
                                'Answer Correct Please go to 10th question to Submit all',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black),
                              ), //add some styles
                            )
                          : Container(
                              margin: EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Text(
                                _questions[_currentIndex]['question'] ?? '',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w300),
                              ),
                            ),
                      SizedBox(height: 10),
                      if (_questions[_currentIndex]['stat'] == 'F')
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: TextField(
                              controller: CpntrollerList[_currentIndex],
                              decoration: InputDecoration(
                                labelText: 'Enter your answer',
                              ),
                            ),
                          ),
                        ),
                      if (_questions[_currentIndex]['stat'] == 'F')
                        Container(
                          height: 60,
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 182, 222, 255),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextButton(
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              checkAnswer(CpntrollerList[_currentIndex].text,
                                  _currentIndex, context);
                            },
                            child: const Text(
                              'Check',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ), //add some styles
                          ),
                        ),
                      if (_currentIndex == _questions.length - 1)
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.04),
                          child: LoadingBtn(
                            height: 60,
                            borderRadius: 20,
                            animate: true,
                            color: const Color.fromARGB(255, 182, 222, 255),
                            width: MediaQuery.of(context).size.width * 0.92,
                            loader: Container(
                              padding: const EdgeInsets.all(10),
                              width: 40,
                              height: 40,
                              child: const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            onTap:
                                ((startLoading, stopLoading, btnState) async {
                              if (btnState == ButtonState.idle) {
                                startLoading();
                                int elapsedTime = calculateElapsedTime();
                                FocusScope.of(context).unfocus();
                                int countTStat =
                                    countItemsWithTStat(_questions);
                                print(
                                    "Number of items with 'stat' key set to 'T': $countTStat");
                                print('Quiz submitted');
                                print('time is ${elapsedTime}');
                                double points = countTStat / 10;
                                print('points is countTStat / 10  ${points}');
                                double diffOf900andET =
                                    (900 - elapsedTime) * 0.5;
                                double tot = diffOf900andET * points;
                                double roundedValue =
                                    double.parse(tot.toStringAsFixed(2));
                                var ifSubmitted =
                                    await pointAdder(widget.id, roundedValue);

                                if (ifSubmitted == true) {
                                  setState(() {
                                    isSubmitted = true;
                                  });
                                  Future.delayed(Duration(seconds: 3), () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Round2(widget.id)),
                                    );
                                  });
                                }
                                if (isSubmitted == false) {
                                  stopLoading();
                                }

                                stopLoading();
                              }
                            }),
                            child: const Text(
                              'Submit All',
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
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width - 50,
                      width: MediaQuery.of(context).size.width - 50,
                      child: Image.asset('lib/dev_assets/greenTickMark.png'),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 30),
                      child: const Text(
                        '''You have submitted answers for this round Sucessfully and we have stored your results 🤞. Wait patiently, the next round will begin automatically''',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Time Left'),
          backgroundColor: Color.fromARGB(255, 182, 222, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 3.0,
          onPressed: () {
            int et = calculateElapsedTime();
            _openBottomSheet(context, 0, et);
          },
        ),
      ),
    );
  }
}
