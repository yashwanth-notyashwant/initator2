import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:initator/models/user.dart';
import 'package:initator/screens/auth_page.dart';
import 'package:initator/screens/final_screen.dart';

import 'package:initator/widgets/timer_for_round1type.dart';

import 'package:loading_btn/loading_btn.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ignore: must_be_immutable
class Round8 extends StatefulWidget {
  late String id;

  Round8(
    this.id,
  );
  @override
  State<Round8> createState() => _Round8State();
}

class _Round8State extends State<Round8> {
  late YoutubePlayerController _cont;

  final videoTextFieldCtr = TextEditingController();
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();

  int _currentIndex = 0;
  bool isSubmitted = false;

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
          val == false ? Icon(Icons.error) : Icon(Icons.fireplace),
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

    super.dispose();
  }

  late FToast fToast;

  final String url = "https://www.youtube.com/watch?v=ncR9Ez-lf-c";

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(url);

    _cont = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(controlsVisibleAtStart: true),
    );

    //

    super.initState();
    fToast = FToast();
    fToast.init(context);
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

  List<Map<String, String>> _questions = [
    {
      "question": "What colour is the shirt of the person at the reception? ",
      "answer": "brown",
      "stat": "F",
    },
    {
      "question": "How many pots are kept on the electric stove in the video? ",
      "answer": "6",
      "stat": "F",
    },
    {
      "question": "What is the colour of the shampoo bottle?",
      "answer": "yellow",
      "stat": "F",
    },
  ];

  @override
  Widget build(BuildContext context) {
    void _showNextQuestion() {
      if (_currentIndex == _questions.length - 1) {
        return;
      }
      setState(() {
        _currentIndex = (_currentIndex + 1) % _questions.length;
      });
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
          print("did uit ");
          print(_questions[_currentIndex]['stat']);
        });
        _showNextQuestion();
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

    List CpntrollerList = [
      _textController1,
      _textController2,
      _textController3,
    ];

    Future<bool> pointAdder(String id, int points) async {
      try {
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(id);
        Timestamp timestamp = Timestamp.now();
        await userRef.update({
          'milestone': [
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
          ],
          'timestampFinal': timestamp,
        });

        var user = await Provider.of<Users>(context, listen: false)
            .fetchUserFromFirestoreForidTinitalTfinal(widget.id);

        int? calculateSecondsTaken() {
          if (user?.timestamp != null && user?.timestampFinal != null) {
            Duration? duration = user?.timestampFinal!
                .toDate()
                .difference(user.timestamp!.toDate());
            return duration?.inSeconds;
          } else {
            return 0; // or some default value indicating that timestamps are not set
          }
        }

        var sec = calculateSecondsTaken();

        await userRef.update({
          'sec': sec,
        });

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

    var wi = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: !isSubmitted
            ? AppBar(
                title: Text(
                  'Round 8',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w400,
                  ),
                ),
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
                      YoutubePlayer(
                        controller: _cont,
                        showVideoProgressIndicator: true,
                        bottomActions: [
                          CurrentPosition(),
                          ProgressBar(
                            isExpanded: true,
                          ),
                          const PlaybackSpeedButton(),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          'Video based questions',
                          // 'Question no:${_currentIndex + 1}',
                          style: TextStyle(
                            fontSize: 15,
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
                                'Answer Correct Please Submit all',
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
                              Fluttertoast.cancel();
                              print(_questions[_currentIndex]['question']
                                  .toString());
                              if (_questions[_currentIndex]['stat'] == 'F') {
                                var toastWidget = toast(false);
                                fToast.showToast(
                                  child: toastWidget,
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: Duration(seconds: 1),
                                );

                                return;
                              }
                              if (btnState == ButtonState.idle) {
                                startLoading();

                                var ifSubmitted =
                                    await pointAdder(widget.id, 0);

                                if (ifSubmitted == true) {
                                  setState(() {
                                    isSubmitted = true;
                                  });
                                  Future.delayed(Duration(seconds: 3), () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FianlScreen()),
                                    );

                                    // goto next-round
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
        floatingActionButton: !isSubmitted
            ? FloatingActionButton.extended(
                icon: const Icon(Icons.warning),
                label: const Text('Warning'),
                backgroundColor: Color.fromARGB(255, 182, 222, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                elevation: 3.0,
                onPressed: () {
                  // int et = calculateElapsedTime();
                  _openBottomSheet(context, 0, 10);
                },
              )
            : null,
      ),
    );
  }

  void snackBar(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
  }
}
