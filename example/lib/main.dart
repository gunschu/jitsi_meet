import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var textController = TextEditingController(text: "test room");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  _joinMeeting();
                },
                child: Text(
                  "join A Jitsi Meeting",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Room",
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  _joinMeetingWithOptions(textController.text);
                },
                child: Text(
                  "join A Jitsi Meeting With Options",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
              )
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

_joinMeetingWithOptions(String roomName) async {
  try {
    String room = roomName.trim().replaceAll(" ", "").toLowerCase();
    String result = await JitsiMeet.joinMeetingWithOptions(
        room ?? "crazyroom", "Here is where crazy happens");
    debugPrint("Result: $result");
  } on TimeoutException {
    debugPrint("Timeout");
  } on DeferredLoadException {
    debugPrint("Library fails to load");
  } catch (error) {
    debugPrint("other error: $error");
  }
}
