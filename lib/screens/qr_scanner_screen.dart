import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:initator/screens/round4_screen.dart';

class QrScannerPage extends StatefulWidget {
  late String id;
  late String answerForQr;

  QrScannerPage(this.answerForQr, this.id);
  @override
  _QrScannerPageState createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  String _scanBarcode = 'Unknown'; // this is where the result is stored

  @override
  void initState() {
    super.initState();
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
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40, left: 10, right: 10),
                  child: Text(
                    "Go to this destination and then scan the QR code.",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
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
                  padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
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
                // if the uknown answer is correct then display the submit button
                Container(
                  // height: 60,
                  margin: EdgeInsets.only(left: 10, right: 10),

                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 182, 222, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(bottom: 5, left: 10, right: 10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => QrScanRoundTrees(widget.id)),
                      );
                    },

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
            );
          },
        ),
      ),
    );
  }
}
