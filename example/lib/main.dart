import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    //initPlatformState();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
          body:  Center(
        child: Column(
          children: <Widget>[
            MaterialButton(onPressed: (){
              _joinMeeting();
            }, child: Text("join A Jitsi Meeting",style: TextStyle(color: Colors.white),),color: Colors.blue,),
            MaterialButton(onPressed: (){
              _joinMeetingWithOptions();
            }, child: Text("join A Jitsi Meeting With Options",style: TextStyle(color: Colors.white),),color: Colors.blue,)
          ],
        ),
      ),
      ),
    );
  }
}

_joinMeeting() async {
  try {
   await JitsiMeet.joinMeeting;
  } on TimeoutException {
    print("Timeout");
  } on DeferredLoadException {
    print("Library fails to load");
  }
}

_joinMeetingWithOptions() async {
  try {
    await JitsiMeet.joinMeetingWithOptions("CRAZYROOM", "Here is where crazy happens");
  } on TimeoutException {
    print("Timeout");
  } on DeferredLoadException {
    print("Library fails to load");
  }
}