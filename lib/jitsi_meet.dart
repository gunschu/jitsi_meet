import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class JitsiMeet {
  static const MethodChannel _channel = const MethodChannel('jitsi_meet');

  static Future<JitsiMeetingResponse> joinMeeting(
      JitsiMeetingOptions options) async {
    assert(options != null);
    assert(options.room != null);
    assert(options.room.trim().isNotEmpty);
    assert(options.room.trim().length >= 3);

    return await _channel
        .invokeMethod<String>('joinMeeting', <String, dynamic>{
          'room': options.room,
          'subject': options.subject,
          'token': options.token,
          'audioMuted': options.audioMuted,
          'audioOnly': options.audioOnly,
          'videoMuted': options.videoMuted,
          'userDisplayName': options.userDisplayName,
          'userEmail': options.userEmail,
        })
        .then((message) =>
            JitsiMeetingResponse(isSuccess: true, message: message))
        .catchError((error) {
          debugPrint("error: $error, type: ${error.runtimeType}");
          return JitsiMeetingResponse(
              isSuccess: false, message: error.toString(), error: error);
        });
  }
}

class JitsiMeetingResponse {
  final bool isSuccess;
  final String message;
  final dynamic error;

  JitsiMeetingResponse({this.isSuccess, this.message, this.error});
}

class JitsiMeetingOptions {
  String room;
  String subject;
  String token;
  bool audioMuted;
  bool audioOnly;
  bool videoMuted;
  String userDisplayName;
  String userEmail;

/* Not used yet, needs more research
  String serverURL;
  Bundle colorScheme;
  Bundle featureFlags;
  String userAvatarURL;
*/

}
