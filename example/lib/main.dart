import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eko_jitsi/feature_flag/feature_flag_enum.dart';
import 'package:eko_jitsi/eko_jitsi.dart';
import 'package:eko_jitsi/eko_jitsi_listener.dart';
import 'package:eko_jitsi/room_name_constraint.dart';
import 'package:eko_jitsi/room_name_constraint_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'life_cycle_manager.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final serverText = TextEditingController();
  final roomText = TextEditingController(text: "plugintestroom");
  final subjectText = TextEditingController(text: "My Plugin Test Meeting");
  final nameText = TextEditingController(text: "Plugin Test User");
  final emailText = TextEditingController(text: "fake@email.com");
  var isAudioOnly = true;
  var isAudioMuted = true;
  var isVideoMuted = true;

  //add this under all variable declare
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//add this under _onError() method
  Future<bool> saveBoolPreference(bool check) async {
    SharedPreferences prefs = await _prefs;
    setState(() {
      bool checkmeet = check;
      prefs.setBool('checkmeet', checkmeet);
      print('SharedPref of checkmeet: $checkmeet');
    });
  }

  @override
  void initState() {
    super.initState();
    EkoJitsi.addListener(EkoJitsiListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onWhiteboardClicked: _onWhiteboardClicked,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    EkoJitsi.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
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
                  controller: serverText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Server URL",
                      hintText: "Hint: Leave empty for meet.jitsi.si"),
                ),
                SizedBox(
                  height: 16.0,
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
    String serverUrl =
        serverText.text?.trim()?.isEmpty ?? "" ? null : serverText.text;

    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README

      Map<FeatureFlagEnum, bool> flags = new HashMap();
      flags[FeatureFlagEnum.ADD_PEOPLE_ENABLED] = false;
      flags[FeatureFlagEnum.CALENDAR_ENABLED] = false;
      flags[FeatureFlagEnum.CHAT_ENABLED] = true;
      flags[FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED] = true;
      flags[FeatureFlagEnum.INVITE_ENABLED] = false;
      flags[FeatureFlagEnum.IOS_RECORDING_ENABLED] = false;
      flags[FeatureFlagEnum.LIVE_STREAMING_ENABLED] = false;
      flags[FeatureFlagEnum.MEETING_NAME_ENABLED] = true;
      flags[FeatureFlagEnum.MEETING_PASSWORD_ENABLED] = false;
      flags[FeatureFlagEnum.RAISE_HAND_ENABLED] = false;
      flags[FeatureFlagEnum.RECORDING_ENABLED] = false;
      flags[FeatureFlagEnum.TILE_VIEW_ENABLED] = true;
      flags[FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE] = false;
      flags[FeatureFlagEnum.TOOLBOX_ENABLED] = true;
      flags[FeatureFlagEnum.VIDEO_SHARE_BUTTON_ENABLED] = false;
      flags[FeatureFlagEnum.NOTIFICATIONS_ENABLED] = true;
      flags[FeatureFlagEnum.WELCOME_PAGE_ENABLED] = false;
      flags[FeatureFlagEnum.IOS_SCREENSHARING_ENABLED] = false;

      // Here is an example, disabling features for each platform
      // if (Platform.isAndroid) {
      //   // Disable ConnectionService usage on Android to avoid issues (see README)
      //   flags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      // } else if (Platform.isIOS) {
      //   // Disable PIP on iOS as it looks weird
      //   flags[FeatureFlagEnum.PIP_ENABLED] = false;
      // }

      // Define meetings options here
      var options = JitsiMeetingOptions()
        ..room = roomText.text
        ..serverURL = serverUrl
        ..subject = subjectText.text
        ..userDisplayName = nameText.text
        ..userEmail = emailText.text
        ..audioOnly = isAudioOnly
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..featureFlags = flags;

      debugPrint("JitsiMeetingOptions: $options");
      await EkoJitsi.joinMeeting(
        options,
        listener: EkoJitsiListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }, onPictureInPictureWillEnter: ({message}) {
          debugPrint("${options.room} entered PIP mode with message: $message");
        }, onPictureInPictureTerminated: ({message}) {
          debugPrint("${options.room} exited PIP mode with message: $message");
        }, onWhiteboardClicked: ({message}) {
          debugPrint(
              "${options.room} whiteboard clicked with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      customContraints = {
    RoomNameConstraintType.MAX_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length <= 50;
    }, "Maximum room name length should be 30."),
    RoomNameConstraintType.FORBIDDEN_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"[$€£]+", caseSensitive: false, multiLine: false)
              .hasMatch(value) ==
          false;
    }, "Currencies characters aren't allowed in room names."),
  };

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
    saveBoolPreference(true);
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
    saveBoolPreference(false);
  }

  void _onWhiteboardClicked({message}) {
    debugPrint("_onWhiteboardClicked broadcasted with message: $message");
    showAlertDialog(context);
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        log("Show Dialog");
        return new AlertDialog(
          title: new Text("My Super title"),
          content: new Text("Hello World"),
        );
      },
    );
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
    saveBoolPreference(false);
  }
}
