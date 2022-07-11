import 'feature_flag_enum.dart';

/// Helper containing the associative map with feature flags and their string values.
/// Reflects the official list of Jitsi Meet SDK 2.9.0 feature flags
/// https://github.com/jitsi/jitsi-meet/blob/master/react/features/base/flags/constants.js
class FeatureFlagHelper {
  static Map<FeatureFlagEnum, String> featureFlags = {
    FeatureFlagEnum.ADD_PEOPLE_ENABLED: 'add-people.enabled',
    FeatureFlagEnum.AUDIO_FOCUS_DISABLED: 'audio-focus.disabled',
    FeatureFlagEnum.ANDROID_AUDIO_FOCUS_DISABLED:
        'android.audio-focus.disabled',
    FeatureFlagEnum.AUDIO_MUTE_BUTTON_ENABLED: 'audio-mute.enabled',
    FeatureFlagEnum.AUDIO_ONLY_BUTTON_ENABLED: 'audio-only.enabled',
    FeatureFlagEnum.CALENDAR_ENABLED: 'calendar.enabled',
    FeatureFlagEnum.CALL_INTEGRATION_ENABLED: 'call-integration.enabled',
    FeatureFlagEnum.CLOSE_CAPTIONS_ENABLED: 'close-captions.enabled',
    FeatureFlagEnum.CONFERENCE_TIMER_ENABLED: 'conference-timer.enabled',
    FeatureFlagEnum.CHAT_ENABLED: 'chat.enabled',
    FeatureFlagEnum.FILMSTRIP_ENABLED: 'filmstrip.enabled',
    FeatureFlagEnum.FULLSCREEN_ENABLED: 'fullscreen.enabled',
    FeatureFlagEnum.HELP_BUTTON_ENABLED: 'help.enabled',
    FeatureFlagEnum.INVITE_ENABLED: 'invite.enabled',
    FeatureFlagEnum.IOS_RECORDING_ENABLED: 'ios.recording.enabled',
    FeatureFlagEnum.IOS_SCREENSHARING_ENABLED: 'ios.screensharing.enabled',
    FeatureFlagEnum.ANDROID_SCREENSHARING_ENABLED:
        'android.screensharing.enabled',
    FeatureFlagEnum.SPEAKERSTATS_ENABLED: 'speakerstats.enabled',
    FeatureFlagEnum.KICK_OUT_ENABLED: 'kick-out.enabled',
    FeatureFlagEnum.LIVE_STREAMING_ENABLED: 'live-streaming.enabled',
    FeatureFlagEnum.LOBBY_MODE_ENABLED: 'lobby-mode.enabled',
    FeatureFlagEnum.MEETING_NAME_ENABLED: 'meeting-name.enabled',
    FeatureFlagEnum.MEETING_PASSWORD_ENABLED: 'meeting-password.enabled',
    FeatureFlagEnum.NOTIFICATIONS_ENABLED: 'notifications.enabled',
    FeatureFlagEnum.OVERFLOW_MENU_ENABLED: 'overflow-menu.enabled',
    FeatureFlagEnum.PIP_ENABLED: 'pip.enabled',
    FeatureFlagEnum.RAISE_HAND_ENABLED: 'raise-hand.enabled',
    FeatureFlagEnum.REACTIONS_ENABLED: 'reactions.enabled',
    FeatureFlagEnum.RECORDING_ENABLED: 'recording.enabled',
    FeatureFlagEnum.REPLACE_PARTICIPANT: 'replace.participant',
    FeatureFlagEnum.RESOLUTION: 'resolution',
    FeatureFlagEnum.SECURITY_OPTIONS_ENABLED: 'security-options.enabled',
    FeatureFlagEnum.SERVER_URL_CHANGE_ENABLED: 'server-url-change.enabled',
    FeatureFlagEnum.TILE_VIEW_ENABLED: 'tile-view.enabled',
    FeatureFlagEnum.TOOLBOX_ALWAYS_VISIBLE: 'toolbox.alwaysVisible',
    FeatureFlagEnum.TOOLBOX_ENABLED: 'toolbox.enabled',
    FeatureFlagEnum.VIDEO_MUTE_BUTTON_ENABLED: 'video-mute.enabled',
    FeatureFlagEnum.VIDEO_SHARE_BUTTON_ENABLED: 'video-share.enabled',
    FeatureFlagEnum.WELCOME_PAGE_ENABLED: 'welcomepage.enabled',
  };
}
