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

}
