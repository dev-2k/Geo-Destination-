import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewTimeline extends StatefulWidget {
  @override
  TimeLine createState() => TimeLine();
}

class TimeLine extends State<WebViewTimeline> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Geo Destination",
          style: TextStyle(
            fontSize: 25,
            fontFamily: 'Billabong',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: WebView(
        initialUrl: 'https://timeline.google.com/maps/timeline',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
