/// Class holding the callback functions for conference events
class JitsiMeetingListener {
  final Function({Map<dynamic, dynamic> message}) onConferenceWillJoin;
  final Function({Map<dynamic, dynamic> message}) onConferenceJoined;
  final Function({Map<dynamic, dynamic> message}) onConferenceTerminated;
  final Function({Map<dynamic, dynamic> message}) onPictureInPictureWillEnter;
  final Function({Map<dynamic, dynamic> message}) onPictureInPictureTerminated;
  final Function(dynamic error) onError;

  JitsiMeetingListener(
      {this.onConferenceWillJoin,
      this.onConferenceJoined,
      this.onConferenceTerminated,
        this.onPictureInPictureWillEnter,
        this.onPictureInPictureTerminated,
      this.onError});
}
