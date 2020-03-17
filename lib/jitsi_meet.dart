import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class JitsiMeet {
  static const MethodChannel _channel = const MethodChannel('jitsi_meet');

  // Alphanumeric, dashes, and underscores only
  static RegExp allowCharsForRoom = RegExp(
    r"^[a-zA-Z0-9-_]+$",
    caseSensitive: false,
    multiLine: false,
  );

  static Future<JitsiMeetingResponse> joinMeeting(
      JitsiMeetingOptions options) async {
    assert(options != null, "options are null");
    assert(options.room != null, "room is null");
    assert(options.room.trim().isNotEmpty, "room is empty");
    assert(options.room.trim().length >= 3, "Minimum room length is 3");
    assert(allowCharsForRoom.hasMatch(options.room),
        "Only alphanumeric, dash, and underscore chars allowed");

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

  @override
  String toString() {
    return 'JitsiMeetingResponse{isSuccess: $isSuccess, message: $message, error: $error}';
  }
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

  @override
  String toString() {
    return 'JitsiMeetingOptions{room: $room, subject: $subject, token: $token, audioMuted: $audioMuted, audioOnly: $audioOnly, videoMuted: $videoMuted, userDisplayName: $userDisplayName, userEmail: $userEmail}';
  }

/* Not used yet, needs more research
  String serverURL;
  Bundle colorScheme;
  Bundle featureFlags;
  String userAvatarURL;
*/

}
