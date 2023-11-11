import 'package:flutter/material.dart';

import 'main.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2000), (() {}));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => MyHomePage()),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Color.fromARGB(255, 20, 20, 20),
          body: Center(
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Image.asset('lib/dev_assets/cicada_image.png'),
            ),
          ),
        ),
      ),
    );
  }
}
