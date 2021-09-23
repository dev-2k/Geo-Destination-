import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<File> savedImageFile;

  String currentAddress = '';
  Position currentposition;
  String url;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      setState(() {
        currentposition = position;
        currentAddress =
            "${place.locality}, ${place.administrativeArea}, ${place.country}";
        locationTextEditingController.text = currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // File file;
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool uploading = false;
  String postId = Uuid().v4();

  Widget bottomSheet() {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 25,
      ),
      child: Column(
        children: [
          Text(
            'Choose Photo',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera,
                    size: 30,
                  ),
                  label: Text(
                    'Camera',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.photo_library_outlined,
                    size: 30,
                  ),
                  label: Text('Gallery', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );

    setState(() {
      _imageFile = pickedFile;
    });
  }

  displayUploadFormScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Geo Destination',
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Billabong',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          FlatButton(
              onPressed: () {},
              child: Icon(
                Icons.share,
                color: Colors.red,
              ))
        ],
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 250,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      image: DecorationImage(
                        image: _imageFile == null
                            ? AssetImage('images/add.png')
                            : FileImage(File(_imageFile.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 220,
            height: 50,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              onPressed: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              color: Colors.red,
              icon: Icon(Icons.add_a_photo_rounded),
              label: Text(
                'Add Image',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(Icons.description_outlined),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                controller: descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Say something about image.',
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.location_history),
            title: Container(
              width: 250,
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                controller: locationTextEditingController,
                decoration: InputDecoration(
                  hintText: 'Write your location',
                  hintStyle: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ),
          Container(
            width: 220,
            height: 110,
            alignment: Alignment.center,
            child: RaisedButton.icon(
                onPressed: _determinePosition,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                color: Colors.red,
                icon: Icon(Icons.location_history_rounded),
                label: Text(
                  'Get my location',
                  style: TextStyle(fontSize: 20),
                )),
          ),
          Container(
            width: 120,
            height: 110,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomRight,
            child: RaisedButton.icon(
              onPressed: () {
                controlUploadAndSave();
                _showToast(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              color: Colors.greenAccent,
              label: Text(
                'Post',
                style: TextStyle(fontSize: 20),
              ),
              icon: Icon(Icons.send_outlined),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return displayUploadFormScreen();
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Added to timeline'),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => throw UnimplementedError();

  controlUploadAndSave() async {
    Reference firebaseStorageReference =
        FirebaseStorage.instance.ref().child(_imageFile.path);
    UploadTask uploadTask =
        firebaseStorageReference.putFile(_imageFile as File);
    uploadTask.whenComplete(() {
      url = firebaseStorageReference.getDownloadURL() as String;
    }).catchError((onError) {
      print(onError);
    });

    // dynamic result = DatabaseService(uid: loggedInUser.uid).uploadPhotos(url);
  }
}
