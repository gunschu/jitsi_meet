import 'dart:collection';

import 'feature_flag_enum.dart';
import 'feature_flag_helper.dart';

class FeatureFlag {
  bool addPeopleEnabled;
  bool calendarEnabled;
  bool callIntegrationEnabled;
  bool closeCaptionsEnabled;
  bool conferenceTimerEnabled;
  bool chatEnabled;
  bool inviteEnabled;
  bool iOSRecordingEnabled;
  bool kickOutEnabled;
  bool liveStreamingEnabled;
  bool meetingNameEnabled;
  bool meetingPasswordEnabled;
  bool pipEnabled;
  bool raiseHandEnabled;
  bool recordingEnabled;
  int _resolution;
  bool serverURLChangeEnabled;
  bool tileViewEnabled;
  bool toolboxAlwaysVisible;
  bool videoShareButtonEnabled;
  bool welcomePageEnabled;

  int get resoulution {
    return _resolution;
  }

  set resolution(int videoResolution) {
    assert(
        videoResolution == FeatureFlagVideoResolution.LD_RESOLUTION ||
            videoResolution == FeatureFlagVideoResolution.MD_RESOLUTION ||
            videoResolution == FeatureFlagVideoResolution.SD_RESOLUTION ||
            videoResolution == FeatureFlagVideoResolution.HD_RESOLUTION,
        """Use FeatureFlagVideoResolution.LD_RESOLUTION for 180p\n
        Use FeatureFlagVideoResolution.MD_RESOLUTION for 360p\n
        Use FeatureFlagVideoResolution.SD_RESOLUTION for 480p\n
        Use FeatureFlagVideoResolution.HD_RESOLUTION for 720p""");
    _resolution = videoResolution;
  }

  Map<String, dynamic> allFeatureFlags() {
    Map<String, dynamic> featureFlags = new HashMap();

    if (addPeopleEnabled != null)
      featureFlags[FeatureFlagHelper
          .featureFlags[FeatureFlagEnum.ADD_PEOPLE_ENABLED]] = addPeopleEnabled;

    if (calendarEnabled != null)
      featureFlags[FeatureFlagHelper
          .featureFlags[FeatureFlagEnum.CALENDAR_ENABLED]] = calendarEnabled;

    if (callIntegrationEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED]] =
          callIntegrationEnabled;

    if (closeCaptionsEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED]] =
          closeCaptionsEnabled;

    if (conferenceTimerEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.CONFERENCE_TIMER_ENABLED]] =
          conferenceTimerEnabled;

    if (chatEnabled != null)
      featureFlags[FeatureFlagHelper
          .featureFlags[FeatureFlagEnum.CHAT_ENABLED]] = chatEnabled;

    if (inviteEnabled != null)
      featureFlags[FeatureFlagHelper
          .featureFlags[FeatureFlagEnum.INVITE_ENABLED]] = inviteEnabled;

    if (iOSRecordingEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.IOS_RECORDING_ENABLED]] =
          iOSRecordingEnabled;

    if (kickOutEnabled != null)
      featureFlags[FeatureFlagHelper
          .featureFlags[FeatureFlagEnum.KICK_OUT_ENABLED]] = kickOutEnabled;

    if (liveStreamingEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.LIVE_STREAMING_ENABLED]] =
          liveStreamingEnabled;

    if (meetingNameEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.MEETING_NAME_ENABLED]] =
          meetingNameEnabled;

    if (meetingPasswordEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.MEETING_PASSWORD_ENABLED]] =
          meetingPasswordEnabled;

    if (pipEnabled != null)
      featureFlags[FeatureFlagHelper
          .featureFlags[FeatureFlagEnum.PIP_ENABLED]] = pipEnabled;

    if (raiseHandEnabled != null)
      featureFlags[FeatureFlagHelper
          .featureFlags[FeatureFlagEnum.RAISE_HAND_ENABLED]] = raiseHandEnabled;

    if (recordingEnabled != null)
      featureFlags[FeatureFlagHelper
          .featureFlags[FeatureFlagEnum.RECORDING_ENABLED]] = recordingEnabled;

    if (_resolution != null)
      featureFlags[FeatureFlagHelper.featureFlags[FeatureFlagEnum.RESOLUTION]] =
          _resolution;

    if (serverURLChangeEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.SERVER_URL_CHANGE_ENABLED]] =
          serverURLChangeEnabled;

    if (tileViewEnabled != null)
      featureFlags[FeatureFlagHelper
          .featureFlags[FeatureFlagEnum.TILE_VIEW_ENABLED]] = tileViewEnabled;

    if (toolboxAlwaysVisible != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE]] =
          toolboxAlwaysVisible;

    if (videoShareButtonEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.VIDEO_SHARE_BUTTON_ENABLED]] =
          videoShareButtonEnabled;

    if (welcomePageEnabled != null)
      featureFlags[FeatureFlagHelper
              .featureFlags[FeatureFlagEnum.WELCOME_PAGE_ENABLED]] =
          welcomePageEnabled;

    return featureFlags;
  }
}

class FeatureFlagVideoResolution {
  /// Video resolution at 180p
  static const LD_RESOLUTION = 180;

  /// Video resolution at 360p
  static const MD_RESOLUTION = 360;

  /// Video resolution at 480p (SD)
  static const SD_RESOLUTION = 480;

  /// Video resolution at 720p (HD)
  static const HD_RESOLUTION = 720;
}
