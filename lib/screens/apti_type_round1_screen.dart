import 'package:flutter/material.dart';
import 'package:initator/screens/qr_scanning_round.dart';

// ignore: must_be_immutable
class Round1Apti15m extends StatefulWidget {
  late String id;
  Round1Apti15m(this.id);
  @override
  State<Round1Apti15m> createState() => _Round1Apti15mState();
}

class _Round1Apti15mState extends State<Round1Apti15m> {
  final List<String> chapters = [
    "Question no:1",
  ];

  final List<String> texts = [
    """Example of Variable in Python

dummy data 
An Example of a Variable in Python is a representational name that serves as a pointer to an object. Once an object is assigned to a variable, it can be referred to by that name. In layman’s terms, we can say that Variable in Python is containers that store values.""",
  ];

  TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                    '${chapters[0]}',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Text(
                    texts[0],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ),
                SizedBox(height: 10),
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
                      // FocusScope.of(context).unfocus();
                      // checkAnswer(_textController.text, currenRandomQuestionIndex,
                      //     context);

                      // // go to the qr code scanning page
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
