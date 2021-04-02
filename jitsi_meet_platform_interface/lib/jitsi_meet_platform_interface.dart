import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'jitsi_meet_options.dart';
import 'jitsi_meet_response.dart';
import 'jitsi_meeting_listener.dart';
import 'method_channel_jitsi_meet.dart';

export 'jitsi_meeting_listener.dart';
export 'jitsi_meet_options.dart';
export 'jitsi_meet_response.dart';
export 'feature_flag/feature_flag_helper.dart';
export 'feature_flag/feature_flag_enum.dart';

abstract class JitsiMeetPlatform extends PlatformInterface {
  /// Constructs a JitsiMeetPlatform.
  JitsiMeetPlatform() : super(token: _token);

  static final Object _token = Object();

  static JitsiMeetPlatform _instance = MethodChannelJitsiMeet();

  /// The default instance of [JitsiMeetPlatform] to use.
  ///
  /// Defaults to [MethodChannelJitsiMeet].
  static JitsiMeetPlatform get instance => _instance;

  static set instance(JitsiMeetPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Joins a meeting based on the JitsiMeetingOptions passed in.
  /// A JitsiMeetingListener can be attached to this meeting that 
  /// will automatically be removed when the meeting has ended
  Future<JitsiMeetingResponse> joinMeeting(JitsiMeetingOptions options,
      {JitsiMeetingListener listener}) async {
    throw UnimplementedError('joinMeeting has not been implemented.');
  }

  closeMeeting() {
    throw UnimplementedError('joinMeeting has not been implemented.');
  }

  /// Adds a JitsiMeetingListener that will broadcast conference events
  addListener(JitsiMeetingListener jitsiMeetingListener) {
    throw UnimplementedError('addListener has not been implemented.');
  }

  /// remove JitsiListener
  removeListener(JitsiMeetingListener jitsiMeetingListener) {
    throw UnimplementedError('removeListener has not been implemented.');
  }

  /// Removes all JitsiMeetingListeners
  removeAllListeners() {
    throw UnimplementedError('removeAllListeners has not been implemented.');
  }

  void initialize() {
    throw UnimplementedError('_initialize has not been implemented.');
  }

  /// execute command interface, use only in web
  void executeCommand(String command, List<String> args) {
    throw UnimplementedError('executeCommand has not been implemented.');
  }

  /// buildView
  /// Method added to support Web plugin, the main purpose is return a <div>
  /// to contain the conferencing screen when start
  /// additionally extra JS can be added usin `extraJS` argument
  /// for mobile is not need because the conferecing view get all device screen
  Widget buildView(List<String> extraJS) {
    throw UnimplementedError('_buildView has not been implemented.');
  }
}
