import 'package:jitsi_meet_platform_interface/jitsi_meet_platform_interface.dart';

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
    this.featureFlags,
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
  FeatureFlags? featureFlags;
  Map<String, dynamic>? webOptions;

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
    FeatureFlags? featureFlags,
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
