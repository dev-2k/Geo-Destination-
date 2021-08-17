import 'package:image_location/components/constants.dart';
import 'package:image_location/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:image_location/screens/registration_screen.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/Geo.png'),
                  height: 100.0,
                ),
              ),
            ),
            Center(
              child: TypewriterAnimatedTextKit(
                text: ['GeoDestination'],
                textStyle: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: Colors.deepOrangeAccent,
              onPressed: () {
                //Go to login screen.
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            RoundedButton(
              title: 'Register',
              color: Colors.deepOrange,
              onPressed: () {
                //Go to login screen.
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
