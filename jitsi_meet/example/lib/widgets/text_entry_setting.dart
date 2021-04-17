import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

SettingsTile textEntrySetting({
  required String title,
  String? initialText,
  required ValueSetter<String> onSubmit,
}) {
  if (kIsWeb) {
    return _TextEntrySettingWeb(
        title: title, initialText: initialText, onSubmit: onSubmit);
  }

  return SettingsTile(
    title: title,
    subtitle: initialText,
    onPressed: (context) async {
      final result = await showTextEntrySetting(
        context,
        'title',
        initialText: initialText,
      );
      onSubmit(result!);
    },
  );
}

/// Text Entry Setting for web, with a text field trailing the title.
class _TextEntrySettingWeb extends SettingsTile {
  _TextEntrySettingWeb({
    required String title,
    String? initialText,
    required ValueSetter<String> onSubmit,
  }) : super(
          title: title,
          trailing: TextFormField(
            initialValue: initialText,
            onChanged: onSubmit,
          ),
        );
}

/// {@template text_entry_setting}
/// A text entry dialog that returns the text entered on submit. If the dialog
/// is canceled, the `initialText` is returned. Usage:
///
/// ```
/// final text = await showTextEntrySetting(context, 'title',
///   initialText: 'initial');
/// ```
/// {@endtemplate}
Future<String?> showTextEntrySetting(BuildContext context, String title,
    {String? initialText}) {
  return showDialog<String>(
    context: context,
    builder: (_) => _TextEntrySettingMobile(
      title: title,
      initialText: initialText,
    ),
    useRootNavigator: true,
  );
}

/// {@macro text_entry_setting}
class _TextEntrySettingMobile extends StatefulWidget {
  /// {@macro text_entry_setting}
  _TextEntrySettingMobile({Key? key, required this.title, this.initialText})
      : super(key: key);

  final String title;
  final String? initialText;

  @override
  _TextEntrySettingMobileState createState() => _TextEntrySettingMobileState();
}

class _TextEntrySettingMobileState extends State<_TextEntrySettingMobile> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onSubmit(widget.initialText);
        return false;
      },
      child: AlertDialog(
        title: Text('Update ${widget.title}'),
        content: TextField(
          controller: _controller,
          onSubmitted: _onSubmit,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => _onSubmit(widget.initialText),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _onSubmit(_controller.text),
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _onSubmit(String? value) {
    Navigator.pop(context, value);
  }
}
