import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:initator/screens/round1_screen.dart';

// ignore: must_be_immutable
class InstructionsScreen extends StatefulWidget {
  late String id;
  InstructionsScreen(this.id);
  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  final List<String> chapters = [
    " Instructions ",
  ];

  final List<String> texts = [
    """ 


• Upon initiating the start process, you acknowledge and agree to adhere to the following terms and conditions:

1. Completion of all 9 rounds is required for your results to be stored in our database.
2. The start time is recorded when the start button is pressed.
3. The result calculation involves the difference between the user's start time and end time.
4. There is no negative marking; however, there will be an 8-second delay for each answer validation, whether correct or incorrect.
5. In the rare event of an application malfunction, try restarting the application; your progress will be saved after pressing the submit button for each round.
6. Only the top 5 participants, evaluated based on time, will advance to the final offline round.
7. In the case of application failure (even after restarting the application), users experiencing glitches or bugs will be refunded the entry fee.
8. DevOps disclaims responsibility for any harm or loss of valuable items in the playing arena.

 

""",
  ];

  Future<bool> pointAdder(String id) async {
    try {
      // mark the list [0,0,0,0,0,0,0,0] to -- > [1,0,0,0,0,0,0,0]
      // Get a reference to the user's document in Firestore
      DocumentReference userRef =
          FirebaseFirestore.instance.collection('users').doc(id);
      Timestamp timestamp = Timestamp.now();

      await userRef.update({
        'isStarted': true,
        'timestamp': timestamp,
      });

      print('Milestone updated successfully.');

      return true;
    } catch (error) {
      print('Error updating milestone: $error');

      return false;
    }
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
          actions: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 182, 222, 255),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.only(right: 20, top: 10),
              child: TextButton(
                onPressed: () async {
                  await pointAdder(widget.id);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        // builder: (context) => WaitingList(widget.id))
                        builder: (context) => Round1(widget.id)),
                    // builder: (context) => QrScanRound(widget.id)),
                  );
                },
                child: Text(
                  " Start >>",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
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
                  margin:
                      EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                  child: Text(
                    texts[0],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
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
