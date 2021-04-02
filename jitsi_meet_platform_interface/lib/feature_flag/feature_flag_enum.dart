/// Enumeration of all available feature flags
/// Reflects the official list of Jitsi Meet SDK 2.9.0 feature flags
/// https://github.com/jitsi/jitsi-meet/blob/master/react/features/base/flags/constants.js
enum FeatureFlagEnum {
  /// Flag indicating if add-people functionality should be enabled.
  /// Default: enabled (true).
  ADD_PEOPLE_ENABLED,

  /// Flag indicating if calendar integration should be enabled.
  /// Default: enabled (true) on Android, auto-detected on iOS.
  CALENDAR_ENABLED,

  /// Flag indicating if call integration (CallKit on iOS, 
  /// ConnectionService on Android)
  /// should be enabled.
  /// Default: enabled (true).
  CALL_INTEGRATION_ENABLED,

  /// Flag indicating if close captions should be enabled.
  /// Default: enabled (true).
  CLOSE_CAPTIONS_ENABLED,

  /// Flag indicating if chat should be enabled.
  /// Default: enabled (true).
  CHAT_ENABLED,

  /// Flag indicating if invite functionality should be enabled.
  /// Default: enabled (true).
  INVITE_ENABLED,

  /// Flag indicating if recording should be enabled in iOS.
  /// Default: disabled (false).
  IOS_RECORDING_ENABLED,

  /// Flag indicating if live-streaming should be enabled.
  /// Default: auto-detected.
  LIVE_STREAMING_ENABLED,

  /// Flag indicating if displaying the meeting name should be enabled.
  /// Default: enabled (true).
  MEETING_NAME_ENABLED,

  /// Flag indicating if the meeting password button should be enabled. Note 
  /// that this flag just decides on the buttton, if a meeting has a password
  /// set, the password ddialog will still show up.
  /// Default: enabled (true).
  MEETING_PASSWORD_ENABLED,

  /// Flag indicating if Picture-in-Picture should be enabled.
  /// Default: auto-detected.
  PIP_ENABLED,

  /// Flag indicating if raise hand feature should be enabled.
  /// Default: enabled.
  RAISE_HAND_ENABLED,

  /// Flag indicating if recording should be enabled.
  /// Default: auto-detected.
  RECORDING_ENABLED,

  /// Flag indicating if tile view feature should be enabled.
  /// Default: enabled.
  TILE_VIEW_ENABLED,

  /// Flag indicating if the toolbox should be always be visible
  /// Default: disabled (false).
  TOOLBOX_ALWAYS_VISIBLE,

  /// Flag indicating if the welcome page should be enabled.
  /// Default: disabled (false).
  WELCOME_PAGE_ENABLED,
}
