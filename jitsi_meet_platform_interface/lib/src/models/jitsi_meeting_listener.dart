/// JitsiMeetingListener
/// Class holding the callback functions for conference events
class JitsiMeetingListener {
  /// Called when Jitsi is preparing to join the user to the conference.
  final Function(Map<dynamic, dynamic> message)? onConferenceWillJoin;

  ///Called when the user has joined the conference.
  final Function(Map<dynamic, dynamic> message)? onConferenceJoined;

  /// Called when the user has exited the conference.
  final Function(Map<dynamic, dynamic> message)? onConferenceTerminated;

  /// Called when the conference is put into PIP mode.
  final Function(Map<dynamic, dynamic> message)? onPictureInPictureWillEnter;

  /// Called when PIP is terminated.
  final Function(Map<dynamic, dynamic> message)? onPictureInPictureTerminated;

  /// Called when Jitsi encounteres an error.
  final Function(dynamic error)? onError;

  /// Generic listeners List for allowed listeners on web
  /// (may be for mobile too)
  final List<JitsiGenericListener>? genericListeners;

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
  final String eventName;
  final Function(dynamic message) callback;

  JitsiGenericListener({required this.eventName, required this.callback});
}
