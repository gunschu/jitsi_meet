/// Holds FeatureFlags.
/// Reflects the official list of Jitsi Meet SDK 3.3.0 feature flags
/// https://github.com/jitsi/jitsi-meet/blob/master/react/features/base/flags/constants.js
class FeatureFlags {
  FeatureFlags({
    this.addPeopleEnabled,
    this.calendarEnabled,
    this.callIntegrationEnabled,
    this.closeCaptionsEnabled,
    this.chatEnabled,
    this.inviteEnabled,
    this.iosRecordingEnabled,
    this.liveStreamingEnabled,
    this.meetingNameEnabled,
    this.meetingPasswordEnabled,
    this.pipEnabled,
    this.raiseHandEnabled,
    this.recordingEnabled,
    this.tileViewEnabled,
    this.toolboxAlwaysVisible,
    this.welcomepageEnabled,
  });

  final bool? addPeopleEnabled;
  final bool? calendarEnabled;
  final bool? callIntegrationEnabled;
  final bool? closeCaptionsEnabled;
  final bool? chatEnabled;
  final bool? inviteEnabled;
  final bool? iosRecordingEnabled;
  final bool? liveStreamingEnabled;
  final bool? meetingNameEnabled;
  final bool? meetingPasswordEnabled;
  final bool? pipEnabled;
  final bool? raiseHandEnabled;
  final bool? recordingEnabled;
  final bool? tileViewEnabled;
  final bool? toolboxAlwaysVisible;
  final bool? welcomepageEnabled;

  Map<String, bool> toMap() {
    final result = <String, bool>{};
    _updateMap(result, 'add-people.enabled', addPeopleEnabled);
    _updateMap(result, 'calendar.enabled', calendarEnabled);
    _updateMap(result, 'call-integration.enabled', callIntegrationEnabled);
    _updateMap(result, 'close-captions.enabled', closeCaptionsEnabled);
    _updateMap(result, 'chat.enabled', chatEnabled);
    _updateMap(result, 'invite.enabled', inviteEnabled);
    _updateMap(result, 'ios.recording.enabled', iosRecordingEnabled);
    _updateMap(result, 'live-streaming.enabled', liveStreamingEnabled);
    _updateMap(result, 'meeting-name.enabled', meetingNameEnabled);
    _updateMap(result, 'meeting-password.enabled', meetingPasswordEnabled);
    _updateMap(result, 'pip.enabled', pipEnabled);
    _updateMap(result, 'raise-hand.enabled', raiseHandEnabled);
    _updateMap(result, 'recording.enabled', recordingEnabled);
    _updateMap(result, 'tile-view.enabled', tileViewEnabled);
    _updateMap(result, 'toolbox.alwaysVisible', toolboxAlwaysVisible);
    _updateMap(result, 'welcomepage.enabled', welcomepageEnabled);

    return result;
  }

  void _updateMap(Map<String, bool> map, String key, bool? value) {
    if (value != null) {
      map.update(key, (oldValue) => value, ifAbsent: () => value);
    }
  }

  FeatureFlags copyWith({
    final bool? addPeopleEnabled,
    final bool? calendarEnabled,
    final bool? callIntegrationEnabled,
    final bool? closeCaptionsEnabled,
    final bool? chatEnabled,
    final bool? inviteEnabled,
    final bool? iosRecordingEnabled,
    final bool? liveStreamingEnabled,
    final bool? meetingNameEnabled,
    final bool? meetingPasswordEnabled,
    final bool? pipEnabled,
    final bool? raiseHandEnabled,
    final bool? recordingEnabled,
    final bool? tileViewEnabled,
    final bool? toolboxAlwaysVisible,
    final bool? welcomepageEnabled,
  }) {
    return FeatureFlags(
      addPeopleEnabled: addPeopleEnabled ?? this.addPeopleEnabled,
      calendarEnabled: calendarEnabled ?? this.calendarEnabled,
      callIntegrationEnabled:
          callIntegrationEnabled ?? this.callIntegrationEnabled,
      closeCaptionsEnabled: closeCaptionsEnabled ?? this.closeCaptionsEnabled,
      chatEnabled: chatEnabled ?? this.chatEnabled,
      inviteEnabled: inviteEnabled ?? this.inviteEnabled,
      iosRecordingEnabled: iosRecordingEnabled ?? this.iosRecordingEnabled,
      liveStreamingEnabled: liveStreamingEnabled ?? this.liveStreamingEnabled,
      meetingNameEnabled: meetingNameEnabled ?? this.meetingNameEnabled,
      meetingPasswordEnabled:
          meetingPasswordEnabled ?? this.meetingPasswordEnabled,
      pipEnabled: pipEnabled ?? this.pipEnabled,
      raiseHandEnabled: raiseHandEnabled ?? this.raiseHandEnabled,
      recordingEnabled: recordingEnabled ?? this.recordingEnabled,
      tileViewEnabled: tileViewEnabled ?? this.tileViewEnabled,
      toolboxAlwaysVisible: toolboxAlwaysVisible ?? this.toolboxAlwaysVisible,
      welcomepageEnabled: welcomepageEnabled ?? this.welcomepageEnabled,
    );
  }
}
