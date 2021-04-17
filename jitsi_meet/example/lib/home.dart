import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet_example/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late JitsiMeetingOptions options;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
    options = JitsiMeetingOptions(
        room: 'plugintestroom',
        serverURL: 'https://meet.jit.si',
        subject: 'My Plugin Test Meeting',
        userDisplayName: 'Plugin Test User',
        userEmail: 'fake@email.com',
        iosAppBarRGBAColor: '#0080FF80',
        audioOnly: true,
        audioMuted: true,
        videoMuted: true,
        featureFlags: FeatureFlags(
          addPeopleEnabled: true,
          calendarEnabled: true,
          callIntegrationEnabled: true,
          closeCaptionsEnabled: true,
          chatEnabled: true,
          inviteEnabled: true,
          iosRecordingEnabled: true,
          liveStreamingEnabled: true,
          meetingNameEnabled: true,
          meetingPasswordEnabled: true,
          pipEnabled: true,
          raiseHandEnabled: true,
          recordingEnabled: true,
          tileViewEnabled: true,
          toolboxAlwaysVisible: false,
          welcomepageEnabled: false,
        ),
        webOptions: {
          "roomName": 'plugintestroom',
          "width": "100%",
          "height": "100%",
          "enableWelcomePage": false,
          "chromeExtensionBanner": null,
          "userInfo": {"displayName": 'Plugin Test User'}
        });
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    // Web settings are on left pane, while meeting is on right pane
    // Mobile settings take the whole screen
    return Scaffold(
      appBar: AppBar(
        title: Text('Jitsi Meet Dev'),
      ),
      body: kIsWeb ? _webHome() : _settings(),
      bottomSheet: kIsWeb ? SizedBox() : _launchButtonMobile(),
    );
  }

  Widget _launchButtonMobile() {
    return SizedBox(
      height: 80.0,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          JitsiMeet.joinMeeting(options);
        },
        child: Text(
          'Launch',
          style: TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.blue),
        ),
      ),
    );
  }

  Settings _settings() {
    return Settings(
      options: options,
      onChange: (value) {
        setState(() {
          options = value;
        });
      },
    );
  }

  Widget _webHome() {
    double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * 0.30,
          child: _settings(),
        ),
        Container(
          width: width * 0.60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white54,
              child: SizedBox(
                width: width * 0.60 * 0.70,
                height: width * 0.60 * 0.70,
                child: JitsiMeetConferencing(
                  extraJS: [
                    // extraJs setup example
                    '<script>function echo(){console.log("echo!!!")};</script>',
                    '<script src="https://code.jquery.com/jquery-3.5.1.slim.js" integrity="sha256-DrT5NfxfbHvMHux31Lkhxg42LY6of8TaYyK50jnxRnM=" crossorigin="anonymous"></script>'
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onConferenceWillJoin(message) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined(message) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated(message) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
