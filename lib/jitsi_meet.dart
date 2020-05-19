import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'jitsi_meeting_listener.dart';

class JitsiMeet {
  static const MethodChannel _channel = const MethodChannel('jitsi_meet');
  static const EventChannel _eventChannel =
      const EventChannel('jitsi_meet_events');

  static List<JitsiMeetingListener> _listeners = <JitsiMeetingListener>[];
  static Map<String, JitsiMeetingListener> _perMeetingListeners = {};
  static bool _hasInitialized = false;

  // Alphanumeric, dashes, and underscores only
  static RegExp _allowCharsForRoom = RegExp(
    r"^[a-zA-Z0-9-_]+$",
    caseSensitive: false,
    multiLine: false,
  );

  /// Joins a meeting based on the JitsiMeetingOptions passed in.
  /// A JitsiMeetingListener can be attached to this meeting that will automatically
  /// be removed when the meeting has ended
  static Future<JitsiMeetingResponse> joinMeeting(JitsiMeetingOptions options,
      {JitsiMeetingListener listener}) async {
    assert(options != null, "options are null");
    assert(options.room != null, "room is null");
    assert(options.room.trim().isNotEmpty, "room is empty");
    assert(options.room.trim().length >= 3, "Minimum room length is 3");
    assert(_allowCharsForRoom.hasMatch(options.room),
        "Only alphanumeric, dash, and underscore chars allowed");

    // Validate serverURL is absolute if it is not null or empty
    if (options.serverURL?.isNotEmpty ?? false) {
      assert(Uri.parse(options.serverURL).isAbsolute,
          "URL must be of the format <scheme>://<host>[/path], like https://someHost.com");
    }

    if (options.iosAppBarRGBAColor == null) {
      options.iosAppBarRGBAColor = "#00000000";
    } else if (options.iosAppBarRGBAColor.length < 8) {
      debugPrint("Hex Value is not RGBA");
      options.iosAppBarRGBAColor = "#00000000";
    }

    // Attach a listener if it exists. The key is based on the serverURL + room
    if (listener != null) {
      String serverURL = options.serverURL ?? "https://meet.jit.si";
      String key;
      if (serverURL.endsWith("/")) {
        key = serverURL + options.room;
      } else {
        key = serverURL + "/" + options.room;
      }

      _perMeetingListeners.update(key, (oldListener) => listener,
          ifAbsent: () => listener);
      _initialize();
    }

    return await _channel
        .invokeMethod<String>('joinMeeting', <String, dynamic>{
          'room': options.room?.trim(),
          'serverURL': options.serverURL?.trim(),
          'subject': options.subject,
          'token': options.token,
          'audioMuted': options.audioMuted,
          'audioOnly': options.audioOnly,
          'videoMuted': options.videoMuted,
          'pipEnabled': options.pipEnabled,
          'addPeopleEnabled': options.addPeopleEnabled,
          'calendarEnabled': options.calendarEnabled,
          'chatEnabled': options.chatEnabled,
          'inviteEnabled': options.inviteEnabled,
          'userDisplayName': options.userDisplayName,
          'userEmail': options.userEmail,
          'iosAppBarRGBAColor': options.iosAppBarRGBAColor,
        })
        .then((message) =>
            JitsiMeetingResponse(isSuccess: true, message: message))
        .catchError((error) {
          debugPrint("error: $error, type: ${error.runtimeType}");
          return JitsiMeetingResponse(
              isSuccess: false, message: error.toString(), error: error);
        });
  }

  /// Initializes the event channel. Call when listeners are added
  static _initialize() {
    if (!_hasInitialized) {
      debugPrint('Jitsi Meet - initializing event channel');
      _eventChannel.receiveBroadcastStream().listen((dynamic message) {
        debugPrint('Jitsi Meet - broadcast event: $message');
        _broadcastToGlobalListeners(message);
        _broadcastToPerMeetingListeners(message);
      }, onError: (dynamic error) {
        debugPrint('Jitsi Meet broadcast error: $error');
        _listeners.forEach((listener) {
          if (listener.onError != null) listener.onError(error);
        });
        _perMeetingListeners.forEach((key, listener) {
          if (listener.onError != null) listener.onError(error);
        });
      });
      _hasInitialized = true;
    }
  }

  /// Adds a JitsiMeetingListener that will broadcast conference events
  static addListener(JitsiMeetingListener jitsiMeetingListener) {
    debugPrint('Jitsi Meet - addListener');
    _listeners.add(jitsiMeetingListener);
    _initialize();
  }

  /// Sends a broadcast to global listeners added using addListener
  static void _broadcastToGlobalListeners(message) {
    _listeners.forEach((listener) {
      switch (message['event']) {
        case "onConferenceWillJoin":
          if (listener.onConferenceWillJoin != null)
            listener.onConferenceWillJoin(message: message);
          break;
        case "onConferenceJoined":
          if (listener.onConferenceJoined != null)
            listener.onConferenceJoined(message: message);
          break;
        case "onConferenceTerminated":
          if (listener.onConferenceTerminated != null)
            listener.onConferenceTerminated(message: message);
          break;
      }
    });
  }

  /// Sends a broadcast to per meeting listeners added during joinMeeting
  static void _broadcastToPerMeetingListeners(message) {
    String url = message['url'];
    final listener = _perMeetingListeners[url];
    if (listener != null) {
      switch (message['event']) {
        case "onConferenceWillJoin":
          if (listener.onConferenceWillJoin != null)
            listener.onConferenceWillJoin(message: message);
          break;
        case "onConferenceJoined":
          if (listener.onConferenceJoined != null)
            listener.onConferenceJoined(message: message);
          break;
        case "onConferenceTerminated":
          if (listener.onConferenceTerminated != null)
            listener.onConferenceTerminated(message: message);

          // Remove the listener from the map of _perMeetingListeners on terminate
          _perMeetingListeners.remove(listener);
          break;
      }
    }
  }

  /// Removes the JitsiMeetingListener specified
  static removeListener(JitsiMeetingListener jitsiMeetingListener) {
    _listeners.remove(jitsiMeetingListener);
  }

  /// Removes all JitsiMeetingListeners
  static removeAllListeners() {
    _listeners.clear();
  }
}

class JitsiMeetingResponse {
  final bool isSuccess;
  final String message;
  final dynamic error;

  JitsiMeetingResponse({this.isSuccess, this.message, this.error});

  @override
  String toString() {
    return 'JitsiMeetingResponse{isSuccess: $isSuccess, message: $message, error: $error}';
  }
}

class JitsiMeetingOptions {
  String room;
  String serverURL;
  String subject;
  String token;
  bool audioMuted;
  bool audioOnly;
  bool videoMuted;
  bool pipEnabled;
  bool addPeopleEnabled;
  bool calendarEnabled;
  bool chatEnabled;
  bool inviteEnabled;
  String userDisplayName;
  String userEmail;
  String iosAppBarRGBAColor;

  @override
  String toString() {
    return 'JitsiMeetingOptions{room: $room, serverURL: $serverURL, subject: $subject, token: $token, audioMuted: $audioMuted, audioOnly: $audioOnly, videoMuted: $videoMuted, pipEnabled: $pipEnabled, addPeopleEnabled: $addPeopleEnabled, calendarEnabled: $calendarEnabled, chatEnabled: $chatEnabled, inviteEnabled: $inviteEnabled userDisplayName: $userDisplayName, userEmail: $userEmail, iosAppBarRGBAColor :$iosAppBarRGBAColor }';
  }

/* Not used yet, needs more research
  Bundle colorScheme;
  Bundle featureFlags;
  String userAvatarURL;
*/

}
