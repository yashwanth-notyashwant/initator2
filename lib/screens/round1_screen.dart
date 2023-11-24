import 'package:flutter/material.dart';
import 'package:initator/widgets/timer_widget.dart';
import 'package:provider/provider.dart';

class QuizPageConditionals extends StatefulWidget {
  // int score;
  // String id;
  // QuizPageConditionals(this.score, this.id);
  @override
  _QuizPageConditionalsState createState() => _QuizPageConditionalsState();
}

class _QuizPageConditionalsState extends State<QuizPageConditionals> {
  int currentQuestionIndex = 0;
  List<Map<String, dynamic>> variable = [
    {
      'question':
          'What is a conditional statement in Python? What is a conditional statement in Python? What is a conditional statement in Python? What is a conditional statement in Python? What is a conditional statement in Pythoatement in Python? What is a conditional statement in Python? What is a conditional statement in Python? What is a conditional statement in Pythoatement in Python? What is a conditional statement in Python? What is a conditional statement in Python? What is a conditional statement in Python?Python? What is a conditional statement in Pythoatement in Python? What is a conditional statement in Python? What is a conditional statement in Python? What is a conditional statement in Pythoatement in Python? What is a conditional statement in Python? What is a conditional statement in Python? What is a conditional statement in Python?',
      'options': [
        'a) A statement that always executes',
      ],
      'correctAnswerIndex': 0,
      'hint':
          """ Explanation: A conditional statement in Python is used to make decisions in your code based on certain conditions. It allows your program to take different paths and execute different code blocks depending on whether the specified condition is true or false.
 """,
    },
    {
      'question':
          'Which keyword is used to define a simple if statement in Python?',
      'options': [
        'a) for',
      ],
      'correctAnswerIndex': 0,
      'hint':
          """ Explanation: In Python, you use the `if` keyword to define a simple conditional statement. The code block under the `if` statement is executed only if the specified condition is true.
 """,
    },
    {
      'question': 'What is the purpose of the else statement in Python?',
      'options': [
        'a) To define a loop',
      ],
      'correctAnswerIndex': 0,
      'hint':
          """ Explanation: The `else` statement in Python is used to provide an alternative code block that is executed when the condition specified in the preceding `if` statement is false. It allows you to handle different scenarios in your code.
 """,
    },
    {
      'question':
          'Which of the following is a valid Python comparison operator?',
      'options': [
        'a) **',
      ],
      'correctAnswerIndex': 0,
      'hint':
          """ Explanation: The `!=` operator is a valid Python comparison operator used to check if two values are not equal to each other. It is used in conditional expressions to compare values.
 """,
    },
    {
      'question': 'What is the purpose of the elif statement in Python?',
      'options': [
        'a) To define a loop',
      ],
      'correctAnswerIndex': 0,
      'hint':
          """ Explanation: The `elif` statement in Python is used to provide an additional condition to check when the preceding `if` condition is false. It allows you to handle multiple conditions and execute different code blocks based on the first true condition encountered.
 """,
    },

    // Add more questions and answers here
  ];

  void _openBottomSheet(BuildContext context) {
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
            // CountdownTimer(),
            Container(
              margin: EdgeInsets.only(left: 20, top: 50),
              // color: const Color.fromARGB(255, 255, 247, 247),
              child: Text(
                '${variable[currentQuestionIndex]['hint']}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void checkAnswer(int selectedOptionIndex, BuildContext context) async {
      print(selectedOptionIndex);
      print(currentQuestionIndex);
      int correctAnswerIndex =
          variable[currentQuestionIndex]['correctAnswerIndex'];
      print(correctAnswerIndex);
      if (selectedOptionIndex == correctAnswerIndex) {
        // Handle correct answer
        // print('Correct answer!');
        // call the function if yes then go forward
        // final isdone =
        //     await Provider.of<Users>(context, listen: false).incrementUserScore(
        //   widget.id,
        // );

        setState(() {
          if (currentQuestionIndex < variable.length - 1) {
            currentQuestionIndex++;
          }
        });
        // }
      } else {
        // Handle wrong answer
        print('Wrong answer!');
        _openBottomSheet(context);
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
                _openBottomSheet(context);
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
                  variable[currentQuestionIndex]['question'],
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(height: 30),
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
                  onPressed: () => checkAnswer(0, context),
                  child: Text(
                    currentQuestionIndex < variable.length - 1
                        ? 'Submit'
                        : 'Finish Round 1',
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
