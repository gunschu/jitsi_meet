import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class JitsiMeet {
  static const MethodChannel _channel = const MethodChannel('jitsi_meet');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<JitsiMeetingResponse> joinMeeting(
      JitsiMeetingOptions options) async {
    assert(options != null);
    assert(options.room != null);
    assert(options.room.trim().isNotEmpty);
    assert(options.room.trim().length >= 3);

    return await _channel
        .invokeMethod<String>('joinMeeting', <String, dynamic>{
          'serverURL': options.serverURL,
          'room': options.room,
          'subject': options.subject,
          'token': options.token,
          'audioMuted': options.audioMuted,
          'audioOnly': options.audioOnly,
          'videoMuted': options.videoMuted,
          'userDisplayName': options.userDisplayName,
          'userEmail': options.userEmail,
          'userAvatarURL': options.userAvatarURL,
        })
        .then((message) =>
            JitsiMeetingResponse(isSuccess: true, message: message))
        .catchError((error) {
          debugPrint("error: $error, type: ${error.runtimeType}");
          return JitsiMeetingResponse(isSuccess: false, message: error.message);
        });
  }

  static Future<String> joinMeetingWithOptions(
      String roomName, String subject) async {
    // Errors occurring on the platform side cause invokeMethod to throw
    // PlatformExceptions.
    try {
      return _channel.invokeMethod('joinMeetingWithOptions', <String, dynamic>{
        'roomName': roomName,
        'subject': subject,
      });
    } on PlatformException catch (e) {
      throw 'Unable to join ${roomName}: ${e.message}';
    }
  }
}

class JitsiMeetingResponse {
  final bool isSuccess;
  final String message;

  JitsiMeetingResponse({this.isSuccess, this.message});
}

class JitsiMeetingOptions {
  String serverURL;
  String room;
  String subject;
  String token;
  bool audioMuted;
  bool audioOnly;
  bool videoMuted;
  String userDisplayName;
  String userEmail;
  String userAvatarURL;

/* Not used yet, needs more research
    Bundle colorScheme;
    Bundle featureFlags;
   */

}
