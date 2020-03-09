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
            child:  MaterialButton(onPressed: (){
              _joinMeeting();
            }, child: Text("Show Aleart",style: TextStyle(color: Colors.white),),color: Colors.blue,),)
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