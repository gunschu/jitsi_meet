import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet_example/widgets/widgets.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key, required this.options, required this.onChange})
      : super(key: key);
  final JitsiMeetingOptions options;
  final ValueSetter<JitsiMeetingOptions> onChange;

  @override
  Widget build(BuildContext context) {
    return SettingsList(
      contentPadding: const EdgeInsets.only(top: 20.0, bottom: 120.0),
      sections: [
        SettingsSection(
          title: 'Jitsi Meet Options',
          tiles: [
            _serverUrl(),
            _room(),
            _subject(),
            _userName(),
            _email(),
          ],
        )
      ],
    );
  }

  /// Server URL Setting
  SettingsTile _serverUrl() {
    return textEntrySetting(
      title: 'Server URL',
      initialText: options.serverURL,
      onSubmit: (value) {
        onChange(options..serverURL = value);
      },
    );
  }

  /// Room Setting
  SettingsTile _room() {
    return textEntrySetting(
      title: 'Room Name',
      initialText: options.room,
      onSubmit: (value) {
        onChange(options.copyWith(room: value));
      },
    );
  }

  /// Subject Setting
  SettingsTile _subject() {
    return textEntrySetting(
      title: 'Subject',
      initialText: options.subject,
      onSubmit: (value) {
        onChange(options.copyWith(subject: value));
      },
    );
  }

  /// User Name Setting
  SettingsTile _userName() {
    return textEntrySetting(
      title: 'User Name',
      initialText: options.userDisplayName,
      onSubmit: (value) {
        onChange(options.copyWith(userDisplayName: value));
      },
    );
  }

  // /// Email Setting
  SettingsTile _email() {
    return textEntrySetting(
      title: 'Email',
      initialText: options.userEmail,
      onSubmit: (value) {
        onChange(options.copyWith(userEmail: value));
      },
    );
  }
}
