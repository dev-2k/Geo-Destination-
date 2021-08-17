import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:image_location/components/constants.dart';
import 'package:image_location/components/rounded_button.dart';
import 'home_page.dart';
import 'registration_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  get getToken => null;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final loginStorage = new FlutterSecureStorage();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orangeAccent,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/Geo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['GeoDestination'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter Your email"),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  cursorColor: Colors.black,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: "Enter Your Password"),
                ),
                RoundedButton(
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      UserCredential user =
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                      storeTockenAndData(user);
                      if (user != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }

                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                  title: 'Log In',
                  color: Colors.deepOrangeAccent,
                )
              ],
            ),
          ),
        ));
  }

  Future<void> storeTockenAndData(UserCredential userCredential) async {
    await loginStorage.write(
        key: "token", value: userCredential.credential.token.toString());
    await loginStorage.write(
        key: "userCredential", value: userCredential.toString());
  }

  Future<String> getToken() async {
    return await loginStorage.read(key: 'token');
  }
}

// Navigator.pushNamed(context, HomePage.id);
