import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'webViewMap.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  String currentAddress = 'My Location';
  Position currentposition;

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
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geo Destination'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.asset('images/14.jpg'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              currentAddress,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          currentposition != null
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Latitude = ' + currentposition.latitude.toString(),
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              : Container(),
          currentposition != null
              ? Text(
                  'Longitude = ' + currentposition.longitude.toString(),
                  style: TextStyle(fontSize: 20.0),
                )
              : Container(),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _determinePosition();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Locate me',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  style: TextButton.styleFrom(primary: Colors.orange),
                ),
                FloatingActionButton(
                    child: Icon(Icons.add_location_alt),
                    backgroundColor: Colors.deepOrangeAccent,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WebViewExample()));
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextButton(
              onPressed: () {
                _showToast(context);
              },
              child: Text(
                'Post',
                style: TextStyle(fontSize: 20.0),
              ),
              style: TextButton.styleFrom(primary: Colors.deepOrange),
            ),
          ),
        ],
      )),
    );
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
}
