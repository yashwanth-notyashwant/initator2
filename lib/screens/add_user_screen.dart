import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:initator/models/user.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import '../models/User.dart';

class AddNewUser extends StatefulWidget {
  @override
  State<AddNewUser> createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  // final _form = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _form = GlobalKey<FormState>();

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget sbox(double Height) {
      return SizedBox(height: Height);
    }

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(''),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              children: [
                sbox(20),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 37, 237, 237),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Enter User details  ',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                sbox(20),
                Divider(
                  indent: 40,
                  endIndent: 40,
                  thickness: 5,
                ),
                sbox(30),
                Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //
                      //
                      //
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Name ',
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(
                                  left: 00.0, right: 10.0),
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some value.';
                                  }

                                  return null;
                                },
                                controller: myController1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your full name',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //
                      //
                      //
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Phone Number ',
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(
                                  left: 00.0, right: 10.0),
                            ),
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter 10 dig number';
                                  }

                                  return null;
                                },
                                controller: myController2,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter your 10 dig num ',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //
                      //
                      //
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Password',
                          style: TextStyle(color: Colors.grey, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.grey,
                              ),
                            ),
                            Container(
                              height: 30.0,
                              width: 1.0,
                              color: Colors.grey.withOpacity(0.5),
                              margin: const EdgeInsets.only(
                                  left: 00.0, right: 10.0),
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter some value.';
                                  }

                                  return null;
                                },
                                controller: myController3,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter a secure password',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      //
                      //
                      //
                    ],
                  ),
                ),
                sbox(20),
                sbox(20),
                Spacer(),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 37, 237, 237),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final isValid = _form.currentState!.validate();
                      if (!isValid) {
                        return;
                      }

                      var isUserAdded = await Provider.of<Users>(
                        context,
                        listen: false,
                      ).addUserToFirestore(
                        User(
                            id: myController2.text.toString().trim(),
                            password: myController3.text.toString().trim(),
                            name: myController1.text.toString().trim(),
                            milestone: [
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                              0,
                            ]),
                      );

                      if (isUserAdded == true) {
                        // show a toast
                        Fluttertoast.showToast(
                            msg: " User added sucessfully ",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                            textColor: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 16.0);
                        return;
                      }
                      if (isUserAdded == false) {
                        // show a toast
                        Navigator.pop(context);
                        return;
                      }

                      //  show
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => EventsPage(
                      //           widget.userObtained, widget.emailList)),
                      // ); //
                    },
                    child: Text(
                      'Add User  ',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ),
                sbox(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//just testing out
