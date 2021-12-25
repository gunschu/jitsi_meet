/// Enumeration of all available feature flags
/// Reflects the official list of Jitsi Meet SDK 2.9.0 feature flags
/// https://github.com/jitsi/jitsi-meet/blob/master/react/features/base/flags/constants.js
enum FeatureFlagEnum {
  /// Flag indicating if add-people functionality should be enabled.
  /// Default: enabled (true).
  ADD_PEOPLE_ENABLED,

  ///
  /// Flag indicating if the SDK should not require the audio focus.
  /// Used by apps that do not use Jitsi audio.
  /// Default: disabled (false)
  ///
  AUDIO_FOCUS_DISABLED,

  /// Flag indicating if the SDK should not require the audio focus.
  /// Used by apps that do not use Jitsi audio.
  /// Default: disabled (false)
  ANDROID_AUDIO_FOCUS_DISABLED,

  /// Flag indicating if the audio mute button should be displayed.
  /// Default: enabled (true).
  AUDIO_MUTE_BUTTON_ENABLED,

  ///
  /// Flag indicating that the Audio only button in the overflow menu is enabled.
  /// Default: enabled (true).
  ///
  AUDIO_ONLY_BUTTON_ENABLED,

  /// Flag indicating if calendar integration should be enabled.
  /// Default: enabled (true) on Android, auto-detected on iOS.
  CALENDAR_ENABLED,

  /// Flag indicating if call integration (CallKit on iOS, ConnectionService on Android)
  /// should be enabled.
  /// Default: enabled (true).
  CALL_INTEGRATION_ENABLED,

  /// Flag indicating if close captions should be enabled.
  /// Default: enabled (true).
  CLOSE_CAPTIONS_ENABLED,

  /// Flag indicating if conference timer should be enabled.
  /// Default: enabled (true).
  CONFERENCE_TIMER_ENABLED,

  /// Flag indicating if chat should be enabled.
  /// Default: enabled (true).
  CHAT_ENABLED,

  /// Flag indicating if the filmstrip should be enabled.
  /// Default: enabled (true).
  FILMSTRIP_ENABLED,

  /// Flag indicating if fullscreen (immersive) mode should be enabled.
  /// Default: enabled (true).
  FULLSCREEN_ENABLED,

  /// Flag indicating if the Help button should be enabled.
  /// Default: enabled (true).
  HELP_BUTTON_ENABLED,

  /// Flag indicating if invite functionality should be enabled.
  /// Default: enabled (true).
  INVITE_ENABLED,

  /// Flag indicating if recording should be enabled in iOS.
  /// Default: disabled (false).
  IOS_RECORDING_ENABLED,

  /// Flag indicating if screen sharing should be enabled in iOS.
  /// Default: disabled (false).
  IOS_SCREENSHARING_ENABLED,

  // Flag indicating if screen sharing should be enabled in android.
  //Default: enabled (true).

  ANDROID_SCREENSHARING_ENABLED,

// Flag indicating if speaker statistics should be enabled.
  // Default: enabled (true).
  SPEAKERSTATS_ENABLED,

  /// Flag indicating if kickout is enabled.
  /// Default: enabled (true).
  KICK_OUT_ENABLED,

  /// Flag indicating if live-streaming should be enabled.
  /// Default: auto-detected.
  LIVE_STREAMING_ENABLED,

  ///
  /// Flag indicating if lobby mode button should be enabled.
  /// Default: enabled.
  ///
  LOBBY_MODE_ENABLED,

  /// Flag indicating if displaying the meeting name should be enabled.
  /// Default: enabled (true).
  MEETING_NAME_ENABLED,

  /// Flag indicating if the meeting password button should be enabled.
  /// Note that this flag just decides on the buttton, if a meeting has a password
  /// set, the password ddialog will still show up.
  /// Default: enabled (true).
  MEETING_PASSWORD_ENABLED,

  /// Flag indicating if the notifications should be enabled.
  /// Default: enabled (true).
  NOTIFICATIONS_ENABLED,

  /// Flag indicating if the audio overflow menu button should be displayed.
  /// Default: enabled (true).
  OVERFLOW_MENU_ENABLED,

  /// Flag indicating if Picture-in-Picture should be enabled.
  /// Default: auto-detected.
  PIP_ENABLED,

  /// Flag indicating if raise hand feature should be enabled.
  /// Default: enabled.
  RAISE_HAND_ENABLED,

  //Flag indicating if recording should be enabled.
  // Default: auto-detected.
  REACTIONS_ENABLED,

  /// Flag indicating if recording should be enabled.
  /// Default: auto-detected.
  RECORDING_ENABLED,

//Flag indicating if the user should join the conference with the replaceParticipant functionality.
  // Default: (false).
  REPLACE_PARTICIPANT,

  /// Flag indicating the local and (maximum) remote video resolution. Overrides
  /// the server configuration.
  /// Default: (unset).
  RESOLUTION,

  ///
  /// Flag indicating if the security options button should be enabled.
  /// Default: enabled (true)
  ///
  SECURITY_OPTIONS_ENABLED,

  /// Flag indicating if server URL change is enabled.
  /// Default: enabled (true)
  SERVER_URL_CHANGE_ENABLED,

  /// Flag indicating if tile view feature should be enabled.
  /// Default: enabled.
  TILE_VIEW_ENABLED,

  /// Flag indicating if the toolbox should be always be visible
  /// Default: disabled (false).
  TOOLBOX_ALWAYS_VISIBLE,

  /// Flag indicating if the toolbox should be enabled
  /// Default: enabled.
  TOOLBOX_ENABLED,

  /// Flag indicating if the video mute button should be displayed.
  /// Default: enabled (true).
  VIDEO_MUTE_BUTTON_ENABLED,

  /// Flag indicating if the video share button should be enabled
  /// Default: enabled (true).
  VIDEO_SHARE_BUTTON_ENABLED,

  /// Flag indicating if the welcome page should be enabled.
  /// Default: disabled (false).
  WELCOME_PAGE_ENABLED,
}
