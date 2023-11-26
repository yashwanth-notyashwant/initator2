import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:initator/screens/qr_scanning_round.dart';

// ignore: must_be_immutable
class Round1Apti15m extends StatefulWidget {
  late String id;
  Round1Apti15m(this.id);
  @override
  State<Round1Apti15m> createState() => _Round1Apti15mState();
}

class _Round1Apti15mState extends State<Round1Apti15m> {
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

  final List<String> chapters = [
    "Question no:1",
  ];

  final List<String> texts = [
    """Example of Variable in Python

dummy data 
An Example of a Variable in Python is a representational name that serves as a pointer to an object. Once an object is assigned to a variable, it can be referred to by that name. In layman’s terms, we can say that Variable in Python is containers that store values.""",
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
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _questions.shuffle(); // Shuffle the list of questions at the beginning
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
    // var hi = MediaQuery.of(context).size.height;
    var wi = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
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

                // button only if reached the end
                if (_currentIndex == _questions.length - 1)
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
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        _submitQuiz();
                      },
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
        ),
      ),
    );
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

  void _submitQuiz() {
    // Add logic to handle quiz submission
    // You can navigate to a new screen or show the results
    print('Quiz submitted');
  }
}
