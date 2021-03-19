/// Class holding the callback functions for conference events
class JitsiMeetingListener {
  final Function({Map<dynamic, dynamic> message}) onConferenceWillJoin;
  final Function({Map<dynamic, dynamic> message}) onConferenceJoined;
  final Function({Map<dynamic, dynamic> message}) onConferenceTerminated;
  final Function({Map<dynamic, dynamic> message}) onPictureInPictureWillEnter;
  final Function({Map<dynamic, dynamic> message}) onPictureInPictureTerminated;
  final Function(dynamic error) onError;

  /// Generic listeners List for allowed listeners on web (may be for mobile too)
  final List<JitsiGenericListener> genericListeners;

  JitsiMeetingListener(
      {this.onConferenceWillJoin,
      this.onConferenceJoined,
      this.onConferenceTerminated,
      this.onPictureInPictureTerminated,
      this.onPictureInPictureWillEnter,
      this.onError,
      this.genericListeners});
}

/// Generic listener
class JitsiGenericListener {
  final eventName;
  final Function(dynamic message) callback;

  JitsiGenericListener({this.eventName, this.callback});
}
