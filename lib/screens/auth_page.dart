import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class AuthPage extends StatefulWidget {
  final Color? primaryColor;
  final Color? backgroundColor;

  AuthPage({
    Key? key,
    this.primaryColor = const Color.fromARGB(255, 37, 237, 237),
    this.backgroundColor = const Color.fromARGB(255, 0, 0, 0),
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  @override
  void dispose() {
    myController1.dispose();
    myController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _messangerKey;
    return MaterialApp(
      scaffoldMessengerKey: _messangerKey,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: this.widget.backgroundColor,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 100.0, bottom: 100.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Cicada",
                              style: GoogleFonts.lobster(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.bold,
                                  color: this.widget.primaryColor),
                            ),
                            Text(
                              "Brough you by DEVOPS ",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: this.widget.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Contact number ",
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
                        Padding(
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
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                'Please enter a value !.';
                              }

                              return null;
                            },
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            controller: myController1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your 10 digit  number',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text(
                      "Password",
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Icon(
                            Icons.lock_open,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 30.0,
                          width: 1.0,
                          color: Colors.grey.withOpacity(0.5),
                          margin:
                              const EdgeInsets.only(left: 00.0, right: 10.0),
                        ),
                        Expanded(
                          child: TextFormField(
                            obscureText: true,
                            // key: _formKey,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a value !.';
                              }

                              return null;
                            },
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            controller: myController2,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 37, 237, 237),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                            child: Container(
                              height: 38,
                              child: const Padding(
                                padding: EdgeInsets.only(left: 10.0, top: 5),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 22),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              print(myController1.text.toString());
                              var user = await Provider.of<Users>(context,
                                      listen: false)
                                  .fetchUserFromFirestore(
                                      myController1.text.toString());

                              if (myController2.text.toString().trim() ==
                                  user?.password.toString()) {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => Instructions Page(),
                                //   ),
                                // );

                                print('valid user');
                                print(user?.id.toString());
                                print(user?.milestone.toString());
                                print(user?.name.toString());
                              } else {
                                return;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class Newww extends StatefulWidget {
  @override
  State<Newww> createState() => _NewwwState();
}

class _NewwwState extends State<Newww> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        ),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.amber,
        ),
        onPressed: () {},
      ),
    );
  }
}
