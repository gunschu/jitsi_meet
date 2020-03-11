import 'dart:async';

import 'package:flutter/services.dart';

class JitsiMeet {
  static const MethodChannel _channel =
      const MethodChannel('jitsi_meet');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> get joinMeeting async {
    final String version = await _channel.invokeMethod('openJitsiMeet');
    return version;
  }

  static Future<void> joinMeetingWithOptions(String roomName, String subject) async {
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
