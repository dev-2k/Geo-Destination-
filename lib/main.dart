import 'package:flutter/material.dart';
import 'package:image_location/screens/home_page.dart';
import 'package:image_location/screens/login_screen.dart';
import 'package:image_location/screens/registration_screen.dart';
import 'package:image_location/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = WelcomeScreen();
  LoginScreen loginScreen = LoginScreen();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await loginScreen.getToken;
    if (token != null) {
      setState(() {
        currentPage = HomePage();
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sen',
        primaryColor: Colors.orangeAccent,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      home: currentPage,
    );
  }
}

//
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         fontFamily: 'Sen',
//         primaryColor: Colors.orangeAccent,
//       ),
//       home: HomePage(),
//     );
//   }
// }
