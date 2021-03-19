@JS()
library jitsi;
// The above two lines are required

import 'package:js/js.dart';

/// Extended JitsiMeetExternalAPI class
///
/// see https://jitsi.github.io/handbook/docs/dev-guide/dev-guide-iframe
@JS('jitsi.JitsiMeetAPI')
class JitsiMeetAPI {
  ///
  external JitsiMeetAPI(String domain, String options);

  ///
  external void on(String event, Function(dynamic message) callback);

  ///
  external void executeCommand(String command, List<String> arguments);

  ///
  external void addEventListener(String eventName, Function callback);

  ///
  external void removeEventListener(List<String> listener);

  /// remove instace
  external void dispose();
}
