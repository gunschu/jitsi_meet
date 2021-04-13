import 'dart:async';

import 'package:flutter/material.dart';

import 'room_name_constraint.dart';
import 'room_name_constraint_type.dart';

import 'package:jitsi_meet_platform_interface/jitsi_meet_platform_interface.dart';

export 'package:jitsi_meet_platform_interface/jitsi_meet_platform_interface.dart'
    show
        JitsiMeetingOptions,
        JitsiMeetingResponse,
        JitsiMeetingListener,
        JitsiGenericListener,
        FeatureFlagHelper,
        FeatureFlagEnum;

class JitsiMeet {
  static bool _hasInitialized = false;

  static final Map<RoomNameConstraintType, RoomNameConstraint>
      defaultRoomNameConstraints = {
    RoomNameConstraintType.MIN_LENGTH: new RoomNameConstraint((value) {
      return value.trim().length >= 3;
    }, "Minimum room length is 3"),
    RoomNameConstraintType.ALLOWED_CHARS: new RoomNameConstraint((value) {
      return RegExp(r"^[a-zA-Z0-9-_]+$", caseSensitive: false, multiLine: false)
          .hasMatch(value);
    }, "Only alphanumeric, dash, and underscore chars allowed"),
  };

  /// Joins a meeting based on the JitsiMeetingOptions passed in.
  /// A JitsiMeetingListener can be attached to this meeting that will automatically
  /// be removed when the meeting has ended
  static Future<JitsiMeetingResponse> joinMeeting(JitsiMeetingOptions options,
      {JitsiMeetingListener? listener,
      Map<RoomNameConstraintType, RoomNameConstraint>?
          roomNameConstraints}) async {
    assert(options.room.trim().isNotEmpty, "room is empty");

    // If no constraints given, take default ones
    // (To avoid using constraint, just give an empty Map)
    if (roomNameConstraints == null) {
      roomNameConstraints = defaultRoomNameConstraints;
    }

    // Check each constraint, if it exist
    // (To avoid using constraint, just give an empty Map)
    if (roomNameConstraints.isNotEmpty) {
      for (RoomNameConstraint constraint in roomNameConstraints.values) {
        assert(
            constraint.checkConstraint(options.room), constraint.getMessage());
      }
    }

    // Validate serverURL is absolute if it is not null or empty
    if (options.serverURL?.isNotEmpty ?? false) {
      assert(Uri.parse(options.serverURL!).isAbsolute,
          "URL must be of the format <scheme>://<host>[/path], like https://someHost.com");
    }

    return await JitsiMeetPlatform.instance
        .joinMeeting(options, listener: listener);
  }

  /// Initializes the event channel. Call when listeners are added
  static _initialize() {
    if (!_hasInitialized) {
      JitsiMeetPlatform.instance.initialize();
      _hasInitialized = true;
    }
  }

  static closeMeeting() => JitsiMeetPlatform.instance.closeMeeting();

  /// Adds a JitsiMeetingListener that will broadcast conference events
  static addListener(JitsiMeetingListener jitsiMeetingListener) {
    JitsiMeetPlatform.instance.addListener(jitsiMeetingListener);
    _initialize();
  }

  /// Removes the JitsiMeetingListener specified
  static removeListener(JitsiMeetingListener jitsiMeetingListener) {
    JitsiMeetPlatform.instance.removeListener(jitsiMeetingListener);
  }

  /// Removes all JitsiMeetingListeners
  static removeAllListeners() {
    JitsiMeetPlatform.instance.removeAllListeners();
  }

  /// allow execute a command over a Jitsi live session (only for web)
  static executeCommand(String command, List<String> args) {
    JitsiMeetPlatform.instance.executeCommand(command, args);
  }
}

/// Allow create a interface for web view and attach it as a child
/// optional param `extraJS` allows setup another external JS libraries
/// or Javascript embebed code
class JitsiMeetConferencing extends StatelessWidget {
  final List<String>? extraJS;
  JitsiMeetConferencing({this.extraJS});

  @override
  Widget build(BuildContext context) {
    return JitsiMeetPlatform.instance.buildView(extraJS!);
  }
}
