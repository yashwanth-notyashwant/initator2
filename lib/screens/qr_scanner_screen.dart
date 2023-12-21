import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:initator/screens/round5_screen.dart';
import 'package:loading_btn/loading_btn.dart';

// ignore: must_be_immutable
class QrScannerPageFor1 extends StatefulWidget {
  late String id;
  late int roundCount;
  late String answerForQr;

  QrScannerPageFor1(this.answerForQr, this.id, this.roundCount);
  @override
  _QrScannerPageFor1State createState() => _QrScannerPageFor1State();
}

class _QrScannerPageFor1State extends State<QrScannerPageFor1> {
  bool isSubmitted = false;
  String _scanBarcode = 'Unknown'; // this is where the result is stored
  late FToast fToast;
  @override
  void initState() {
    super.initState();

    fToast = FToast();
    fToast.init(context);
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> pointAdder(String id, double points) async {
      try {
        // Get a reference to the user's document in Firestore
        DocumentReference userRef =
            FirebaseFirestore.instance.collection('users').doc(id);

        // Update the milestone field by incrementing the provided points
        if (widget.roundCount == 1) {
          await userRef.update({
            'milestone': [
              1,
              1,
              1,
              0,
              0,
              0,
              0,
              0,
            ]
          });
        } else if (widget.roundCount == 2) {
          await userRef.update({
            'milestone': [
              1,
              1,
              1,
              1,
              0,
              0,
              0,
              0,
            ]
          });
        }
        print('Milestone updated successfully.');

        return true;
      } catch (error) {
        print('Error updating milestone: $error');

        return false;
      }
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
            Text(val == false
                ? "  Wrong Answer !    "
                : "  Correct Answer !    "),
          ],
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return !isSubmitted
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 40, left: 10, right: 10),
                        child: Text(
                          "Go to this destination and then scan the QR code.",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w300),
                        ),
                      ),
                      Container(
                        // height: 60,
                        margin: EdgeInsets.only(top: 20, left: 10, right: 10),

                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 182, 222, 255),
                          // borderRadius: BorderRadius.circular(20),
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.only(bottom: 5, left: 10, right: 10),
                        child: TextButton(
                          onPressed: () async {
                            await scanQR();
                            print(_scanBarcode);
                            print(widget.answerForQr);
                          },
                          child: const Text(
                            'Start scan',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                                color: Colors.black),
                          ), //add some styles
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          (_scanBarcode == widget.answerForQr)
                              ? "Scan Result: Correct QR"
                              : "Scan Result: Wrong QR",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.62,
                      ),
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
                            if (_scanBarcode != widget.answerForQr) {
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

                              var ifSubmitted = await pointAdder(widget.id, 2);

                              if (ifSubmitted == true) {
                                setState(() {
                                  isSubmitted = true;
                                });
                                Future.delayed(Duration(seconds: 3), () {
                                  if (widget.roundCount == 1) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Round5(widget.id)),
                                    );
                                  } else if (widget.roundCount == 2) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Round5(widget.id)),
                                    );
                                    // ); for the next round do it here
                                    print('camer here ');
                                  }
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
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width - 50,
                          width: MediaQuery.of(context).size.width - 50,
                          child:
                              Image.asset('lib/dev_assets/greenTickMark.png'),
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
                  );
          },
        ),
      ),
    );
  }
}
