@JS()
library jitsi;
// The above two lines are required,
// allows interoperability bettween dart and JS

import 'package:js/js.dart';

/// Extended `JitsiMeetExternalAPI' JS
///
/// Allows Dart code comunicate with the `JitsiMeetExternalAPI`
/// see https://jitsi.github.io/handbook/docs/dev-guide/dev-guide-iframe
@JS('jitsi.JitsiMeetAPI')
class JitsiMeetAPI {
  /// Constructor
  external JitsiMeetAPI(String domain, String options);

  /// Generic handler Js for events
  external void on(String event, Function(dynamic message) callback);

  /// Interface to execute a command with `JitsiMeetExternalAPI`
  external void executeCommand(String command, List<String> arguments);

  /// Add an Event Listener for the `JitsiMeetExternalAPI`
  external void addEventListener(String eventName, Function callback);

  /// Remove Event Listener for the `JitsiMeetExternalAPI`
  external void removeEventListener(List<String> listener);

  /// remove instace
  external void dispose();
}
