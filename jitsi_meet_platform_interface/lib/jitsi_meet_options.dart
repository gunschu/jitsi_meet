import 'dart:collection';

import 'feature_flag/feature_flag_enum.dart';
import 'feature_flag/feature_flag_helper.dart';

class JitsiMeetingOptions {
  JitsiMeetingOptions({
    required this.room,
    this.serverURL,
    this.subject,
    this.token,
    this.audioMuted,
    this.audioOnly,
    this.videoMuted,
    this.userDisplayName,
    this.userEmail,
    this.iosAppBarRGBAColor,
    this.userAvatarURL,
    this.featureFlags = const {},
    this.webOptions,
  });

  final String room;
  String? serverURL;
  String? subject;
  String? token;
  bool? audioMuted;
  bool? audioOnly;
  bool? videoMuted;
  String? userDisplayName;
  String? userEmail;
  String? iosAppBarRGBAColor;
  String? userAvatarURL;

  Map<FeatureFlagEnum, bool> featureFlags = HashMap();

  Map<String, dynamic>? webOptions; // options for web

  /// Get feature flags Map with keys as String instead of Enum
  /// Useful as an argument sent to the Kotlin/Swift code
  Map<String?, bool> getFeatureFlags() {
    Map<String?, bool> featureFlagsWithStrings = HashMap();

    featureFlags.forEach((key, value) {
      featureFlagsWithStrings[FeatureFlagHelper.featureFlags[key]] = value;
    });

    return featureFlagsWithStrings;
  }

  @override
  String toString() {
    return 'JitsiMeetingOptions{room: $room, serverURL: $serverURL, '
        'subject: $subject, token: $token, audioMuted: $audioMuted, '
        'audioOnly: $audioOnly, videoMuted: $videoMuted, '
        'userDisplayName: $userDisplayName, userEmail: $userEmail, '
        'iosAppBarRGBAColor :$iosAppBarRGBAColor, featureFlags: $featureFlags }';
  }

  JitsiMeetingOptions copyWith({
    String? room,
    String? serverURL,
    String? subject,
    String? token,
    bool? audioMuted,
    bool? audioOnly,
    bool? videoMuted,
    String? userDisplayName,
    String? userEmail,
    String? iosAppBarRGBAColor,
    String? userAvatarURL,
    Map<FeatureFlagEnum, bool>? featureFlags = const {},
    Map<String, dynamic>? webOptions,
  }) {
    return JitsiMeetingOptions(
      room: room ?? this.room,
      serverURL: serverURL ?? this.serverURL,
      subject: subject ?? this.subject,
      token: token ?? this.token,
      audioMuted: audioMuted ?? this.audioMuted,
      audioOnly: audioOnly ?? this.audioOnly,
      videoMuted: videoMuted ?? this.videoMuted,
      userDisplayName: userDisplayName ?? this.userDisplayName,
      userEmail: userEmail ?? this.userEmail,
      iosAppBarRGBAColor: iosAppBarRGBAColor ?? this.iosAppBarRGBAColor,
      userAvatarURL: userAvatarURL ?? this.userAvatarURL,
      featureFlags: featureFlags ?? this.featureFlags,
      webOptions: webOptions ?? this.webOptions,
    );
  }

/* Not used yet, needs more research
  Bundle colorScheme;
  String userAvatarURL;
*/

}
