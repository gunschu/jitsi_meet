import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var roomText = TextEditingController(text: "plugintestroom");
  var subjectText = TextEditingController(text: "My Plugin Test Meeting");
  var nameText = TextEditingController(text: "Plugin Test User");
  var emailText = TextEditingController(text: "fake@email.com");
  var avatarText = TextEditingController(
      text:
          "https://github.com/gunschu/jitsi_meet/blob/master/example/web/favicon.png");
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

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
          actions: <Widget>[
            PopupMenuButton(
                icon: Icon(Icons.settings),
                offset: Offset.fromDirection(pi / 2, 48.0),
                itemBuilder: (context) => <PopupMenuEntry>[
                      PopupMenuItem(
                          child: FlatButton(
                        child: Text("Change Server URL (TODO)"),
                      )),
                      PopupMenuItem(
                          child: FlatButton(
                        child: Text("Use Token (TODO)"),
                      )),
                    ]),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 24.0,
                ),
                TextField(
                  controller: roomText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Room",
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: subjectText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Subject",
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: nameText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Display Name",
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: emailText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: avatarText,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Avatar URL",
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  title: Text("Audio Only"),
                  value: isAudioOnly,
                  onChanged: _onAudioOnlyChanged,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  title: Text("Audio Muted"),
                  value: isAudioMuted,
                  onChanged: _onAudioMutedChanged,
                ),
                SizedBox(
                  height: 16.0,
                ),
                CheckboxListTile(
                  title: Text("Video Muted"),
                  value: isVideoMuted,
                  onChanged: _onVideoMutedChanged,
                ),
                Divider(
                  height: 48.0,
                  thickness: 2.0,
                ),
                SizedBox(
                  height: 64.0,
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      _joinMeeting();
                    },
                    child: Text(
                      "Join Meeting",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                MaterialButton(
                  onPressed: () => _joinMeetingWithOptions(roomText.text),
                  child: Text(
                    "Join (Deprecate)",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 48.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onAudioOnlyChanged(bool value) {
    setState(() {
      isAudioOnly = value;
    });
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  _joinMeeting() async {
    try {
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..userAvatarURL = avatarText.text
          ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted

      await JitsiMeet.joinMeeting(options);
    } on TimeoutException {
      print("Timeout");
    } on DeferredLoadException {
      print("Library fails to load");
    }
  }
}

/// Deprecated
/// Will delete later once all platform migrated
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
