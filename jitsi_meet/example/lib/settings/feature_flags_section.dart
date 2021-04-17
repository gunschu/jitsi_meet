import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:settings_ui/settings_ui.dart';

class FeatureFlagsSection {
  FeatureFlagsSection({
    required this.options,
    required this.onChange,
  });

  final JitsiMeetingOptions options;
  final ValueSetter<JitsiMeetingOptions> onChange;

  SettingsSection get() {
    return SettingsSection(
      title: 'Feature Flags',
      tiles: [
        _addPeopleEnabled(),
        _calendarEnabled(),
        _callIntegrationEnabled(),
        _closeCaptionsEnabled(),
        _chatEnabled(),
        _inviteEnabled(),
        _iosRecordingEnabled(),
        _liveStreamingEnabled(),
        _meetingNameEnabled(),
        _meetingPasswordEnabled(),
        _pipEnabled(),
        _raiseHandEnabled(),
        _recordingEnabled(),
        _tileViewEnabled(),
        _toolboxAlwaysVisible(),
        _welcomepageEnabled(),
      ],
    );
  }

  /// Add People
  SettingsTile _addPeopleEnabled() {
    return SettingsTile.switchTile(
      title: 'add-people.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(addPeopleEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.addPeopleEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _calendarEnabled() {
    return SettingsTile.switchTile(
      title: 'calendar.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(calendarEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.calendarEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _callIntegrationEnabled() {
    return SettingsTile.switchTile(
      title: 'call-integration.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(callIntegrationEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.callIntegrationEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _closeCaptionsEnabled() {
    return SettingsTile.switchTile(
      title: 'close-captions.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(closeCaptionsEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.closeCaptionsEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _chatEnabled() {
    return SettingsTile.switchTile(
      title: 'chat.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(chatEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.chatEnabled ?? false,
    );
  }

  /// Invite
  SettingsTile _inviteEnabled() {
    return SettingsTile.switchTile(
      title: 'invite.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(inviteEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.inviteEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _iosRecordingEnabled() {
    return SettingsTile.switchTile(
      title: 'ios.recording.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(iosRecordingEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.iosRecordingEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _liveStreamingEnabled() {
    return SettingsTile.switchTile(
      title: 'live-streaming.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(liveStreamingEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.liveStreamingEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _meetingNameEnabled() {
    return SettingsTile.switchTile(
      title: 'meeting-name.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(meetingNameEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.meetingNameEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _meetingPasswordEnabled() {
    return SettingsTile.switchTile(
      title: 'meeting-password.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(meetingPasswordEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.meetingPasswordEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _pipEnabled() {
    return SettingsTile.switchTile(
      title: 'pip.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(pipEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.pipEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _raiseHandEnabled() {
    return SettingsTile.switchTile(
      title: 'raise-hand.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(raiseHandEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.raiseHandEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _recordingEnabled() {
    return SettingsTile.switchTile(
      title: 'recording.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(recordingEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.recordingEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _tileViewEnabled() {
    return SettingsTile.switchTile(
      title: 'tile-view.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(tileViewEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.tileViewEnabled ?? false,
    );
  }

  /// Add People
  SettingsTile _toolboxAlwaysVisible() {
    return SettingsTile.switchTile(
      title: 'toolbox.alwaysVisible',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(toolboxAlwaysVisible: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.toolboxAlwaysVisible ?? false,
    );
  }

  /// Add People
  SettingsTile _welcomepageEnabled() {
    return SettingsTile.switchTile(
      title: 'welcomepage.enabled',
      onToggle: (bool value) {
        final newFeatureFlags =
            options.featureFlags?.copyWith(welcomepageEnabled: value);
        onChange(options.copyWith(featureFlags: newFeatureFlags));
      },
      switchValue: options.featureFlags?.welcomepageEnabled ?? false,
    );
  }
}
