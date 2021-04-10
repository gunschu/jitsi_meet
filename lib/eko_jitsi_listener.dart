/// Class holding the callback functions for conference events
class EkoJitsiListener {
  final Function({Map<dynamic, dynamic> message}) onConferenceWillJoin;
  final Function({Map<dynamic, dynamic> message}) onConferenceJoined;
  final Function({Map<dynamic, dynamic> message}) onConferenceTerminated;
  final Function(dynamic error) onError;

  EkoJitsiListener(
      {this.onConferenceWillJoin,
      this.onConferenceJoined,
      this.onConferenceTerminated,
      this.onError});
}
