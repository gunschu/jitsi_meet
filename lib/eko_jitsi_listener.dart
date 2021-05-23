/// Class holding the callback functions for conference events
class EkoJitsiListener {
  final Function({Map<dynamic, dynamic> message}) onConferenceWillJoin;
  final Function({Map<dynamic, dynamic> message}) onConferenceJoined;
  final Function({Map<dynamic, dynamic> message}) onConferenceTerminated;
  final Function({Map<dynamic, dynamic> message}) onPictureInPictureWillEnter;
  final Function({Map<dynamic, dynamic> message}) onPictureInPictureTerminated;
  final Function({Map<dynamic, dynamic> message}) onWhiteboardClicked;
  final Function(dynamic error) onError;

  EkoJitsiListener(
      {this.onConferenceWillJoin,
      this.onConferenceJoined,
      this.onConferenceTerminated,
      this.onPictureInPictureWillEnter,
      this.onPictureInPictureTerminated,
      this.onWhiteboardClicked,
      this.onError});
}
