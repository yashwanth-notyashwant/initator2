import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:initator/firebase_options.dart';
import 'package:initator/models/user.dart';
import 'package:initator/screens/auth_page.dart';
import 'package:initator/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      title: 'Flutter Demo',
      // home: MyHomePage(),
      home: Splash(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Users(),
        ),
        // ChangeNotifierProvider.value(
        //   value: ABC(),
        // ), as of now no need
      ],
      child: MaterialApp(
        // home: HodView(),
        home: AuthPage(),
      ),
    );
  }
}

// return const Scaffold(
//       body: Center(
//         child: Text('Welcome'),
//       ),
//     );
