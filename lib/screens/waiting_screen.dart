import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:initator/models/user.dart';

import 'package:initator/screens/instructions_page.dart';

import 'package:loading_btn/loading_btn.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class WaitingList extends StatefulWidget {
  late String id;

  WaitingList(
    this.id,
  );
  @override
  State<WaitingList> createState() => _WaitingListState();
}

class _WaitingListState extends State<WaitingList> {
  final TextEditingController _textController1 = TextEditingController();

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
          val == false ? Icon(Icons.warning) : Icon(Icons.fireplace),
          SizedBox(
            width: 12.0,
          ),
          Text(val == false ? "  Wrong Code !    " : "  Correct Code !    "),
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

  @override
  void initState() {
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
      "question": "Enter the code provided by the DOT team to start the game ",
      "answer": "88",
      "stat": "F",
    },
  ];

  @override
  Widget build(BuildContext context) {
    List CpntrollerList = [
      _textController1,
    ];

    Future<bool> codeFetcherCaller(String answer) async {
      try {
        var code = await Provider.of<Users>(context, listen: false)
            .fetchCodeFromFirestore();
        await Future.delayed(Duration(seconds: 5));
        //
        if (answer == code) {
          return true;
        } else {
          var toastWidget = toast(false);
          fToast.showToast(
            child: toastWidget,
            gravity: ToastGravity.BOTTOM,
            toastDuration: Duration(seconds: 1),
          );
          return false;
        }
      } catch (error) {
        print('Error fetching code : $error');

        return false;
      }
    }

    var wi = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
          appBar: !isSubmitted
              ? AppBar(
                  title: Text(
                    'Waiting Area',
                    style: GoogleFonts.lobster(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              : AppBar(
                  title: Text(''),
                ),
          body: SingleChildScrollView(
            child: Container(
              width: wi,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Note:',
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
                            'Answer Correct Please Submit this',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ), //add some styles
                        )
                      : Container(
                          margin:
                              EdgeInsets.only(left: 20, right: 20, bottom: 10),
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
                            labelText: 'Enter the code ',
                          ),
                        ),
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
                        onTap: ((startLoading, stopLoading, btnState) async {
                          Fluttertoast.cancel();

                          if (btnState == ButtonState.idle) {
                            startLoading();

                            var ifSubmitted =
                                await codeFetcherCaller(_textController1.text);

                            if (ifSubmitted == true) {
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InstructionsScreen(widget.id)),
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
                          'Enter the Game',
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
          )),
    );
  }
}
