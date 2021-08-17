import 'package:flutter/cupertino.dart';
import 'package:image_location/chatPage/chatPage.dart';
import 'package:image_location/components/constants.dart';
import 'package:image_location/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_location/profile/profile_page.dart';
import '../addImage.dart';
import '../detailPage.dart';
import '../timelinePage.dart';
import '../timelineWebView.dart';
import '../timelinePage.dart';
import 'package:image_location/timelinePage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

final _firestore = FirebaseFirestore.instance;
User loggedInUser; // FirebaseUser  ;
// final firebase_storage.Reference storageReference =
//     firebase_storage.FirebaseStorage.instance.ref().child('Post Pictures');
// final postsReference = FirebaseFirestore.instance.collection("posts");

class HomePage extends StatefulWidget {
  static const String id = 'home_page';
  static const String _title = 'Home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    TimeLinePage(),
    WebViewTimeline(),
    ChatPage(),
    // Text('data'),
    ProfilePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orangeAccent,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddImage()));
            },
            child: Icon(Icons.add_a_photo_outlined)),
        iconTheme: IconThemeData(
          color: Colors.white,
          size: 30.0,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        actionsIconTheme: IconThemeData(size: 35),
        title: Text(
          'Geo Destination',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Billabong',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: CupertinoTabBar(
        activeColor: Colors.redAccent,
        backgroundColor: Colors.orangeAccent,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_history_rounded),
              label: 'Timeline Route'),
          BottomNavigationBarItem(
              icon: Icon(Icons.mark_chat_unread_sharp), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),

      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add_a_photo),
      //     backgroundColor: Colors.deepOrangeAccent,
      //     onPressed: () {
      //       Navigator.push(
      //           context, MaterialPageRoute(builder: (context) => AddImage()));
      //     }),
    );
  }
}
