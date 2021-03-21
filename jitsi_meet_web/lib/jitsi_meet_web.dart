import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:jitsi_meet_platform_interface/jitsi_meet_platform_interface.dart';
import 'package:js/js.dart';

import 'jitsi_meet_external_api.dart' as jitsi;
import 'room_name_constraint.dart';
import 'room_name_constraint_type.dart';

/// JitsiMeetPlugin Web version for Jitsi Meet plugin
class JitsiMeetPlugin extends JitsiMeetPlatform {
  // List<JitsiMeetingListener> _listeners = <JitsiMeetingListener>[];
  // Map<String, JitsiMeetingListener> _perMeetingListeners = {};

  /// `JitsiMeetExternalAPI` holder
  jitsi.JitsiMeetAPI api;

  /// Flag to indicate if external JS are already added
  /// used for extra scripts
  bool extraJSAdded = false;

  /// Regex to validate URL
  RegExp cleanDomain = RegExp(r"^https?:\/\/");

  JitsiMeetPlugin._() {
    _setupScripts();
  }

  static final JitsiMeetPlugin _instance = JitsiMeetPlugin._();

  /// Registry web plugin
  static void registerWith(Registrar registrar) {
    JitsiMeetPlatform.instance = _instance;
  }

  /// Joins a meeting based on the JitsiMeetingOptions passed in.
  /// A JitsiMeetingListener can be attached to this meeting
  /// that will automatically be removed when the meeting has ended
  Future<JitsiMeetingResponse> joinMeeting(JitsiMeetingOptions options,
      {JitsiMeetingListener listener,
      Map<RoomNameConstraintType, RoomNameConstraint>
          roomNameConstraints}) async {
    debugPrint("listener $listener");
    // encode `options` Map to Json to avoid error
    // in interoperability conversions
    String webOptions = jsonEncode(options.webOptions);
    debugPrint("webOptions $webOptions");
    String serverURL = options.serverURL ?? "meet.jit.si";
    serverURL = serverURL.replaceAll(cleanDomain, "");
    debugPrint("serverUrl $serverURL");
    api = jitsi.JitsiMeetAPI(serverURL, webOptions);
    // setup listeners
    if (listener != null) {
      api.on("videoConferenceJoined", allowInterop((dynamic _message) {
        // Mapping object according with jitsi external api source code
        Map<String, dynamic> message = {
          "displayName": _message.displayName,
          "roomName": _message.roomName
        };
        listener.onConferenceJoined(message: message);
      }));
      api.on("videoConferenceLeft", allowInterop((dynamic _message) {
        // Mapping object according with jitsi external api source code
        Map<String, dynamic> message = {"roomName": _message.roomName};
        listener.onConferenceTerminated(message: message);
      }));
      api.on("feedbackSubmitted", allowInterop((dynamic message) {
        debugPrint("feedbackSubmitted message: $message");
        listener.onError(message);
      }));

      // NOTE: `onConferenceWillJoin` is not supported or nof found event in web

      // add geeric listener
      _addGenericListeners(listener);

      // force to dispose view when close meeting
      // this is needed to allow create another room in
      // the same view without reload it
      api.on("readyToClose", allowInterop((dynamic message) {
        api.dispose();
      }));
    }

    return JitsiMeetingResponse(isSuccess: true);
  }

  // add generic lister over current session
  _addGenericListeners(JitsiMeetingListener listener) {
    if (api == null) {
      debugPrint("Jistsi instance not exists event can't be attached");
      return;
    }
    debugPrint("genericListeners ${listener.genericListeners}");
    if (listener.genericListeners != null) {
      listener.genericListeners.forEach((item) {
        debugPrint("eventName ${item.eventName}");
        api.on(item.eventName, allowInterop(item.callback));
      });
    }
  }

  @override
  void executeCommand(String command, List<String> args) {
    api.executeCommand(command, args);
  }

  closeMeeting() {
    debugPrint("Closing the meeting");
    api.dispose();
    api = null;
  }

  /// Adds a JitsiMeetingListener that will broadcast conference events
  addListener(JitsiMeetingListener jitsiMeetingListener) {
    debugPrint("Adding listeners");
    _addGenericListeners(jitsiMeetingListener);
  }

  /// Remove JitsiListener
  /// Remove all list of listeners bassed on event name
  removeListener(JitsiMeetingListener jitsiMeetingListener) {
    debugPrint("Removing listeners");
    List<String> listeners = [];
    if (jitsiMeetingListener.onConferenceJoined != null) {
      listeners.add("videoConferenceJoined");
    }
    ;
    if (jitsiMeetingListener.onConferenceTerminated != null) {
      listeners.add("videoConferenceLeft");
    }
    ;
    jitsiMeetingListener.genericListeners
        .forEach((element) => listeners.add(element.eventName));
    api.removeEventListener(listeners);
  }

  /// Removes all JitsiMeetingListeners
  /// Not used for web
  removeAllListeners() {}

  void initialize() {}

  @override
  Widget buildView(List<String> extraJS) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('jitsi-meet-view',
        (int viewId) {
      final div = html.DivElement()
        ..id = "jitsi-meet-section"
        ..style.width = '100%'
        ..style.height = '100%';
      return div;
    });
    // add extraJS only once
    // this validation is needed because the view can be
    // rebuileded several times
    if (!extraJSAdded) {
      _setupExtraScripts(extraJS);
      extraJSAdded = true;
    }

    return HtmlElementView(viewType: 'jitsi-meet-view');
  }

  // setu extra JS Scripts
  void _setupExtraScripts(List<String> extraJS) {
    extraJS?.forEach((element) {
      RegExp regExp = RegExp(r"<script[^>]*>(.*?)<\/script[^>]*>");
      if (regExp.hasMatch(element)) {
        final html.NodeValidatorBuilder validator =
            html.NodeValidatorBuilder.common()
              ..allowElement('script',
                  attributes: ['type', 'crossorigin', 'integrity', 'src']);
        debugPrint("ADD script $element");
        html.ScriptElement script =
            html.Element.html(element, validator: validator);
        html.querySelector('head').children.add(script);
        // html.querySelector('head').appendHtml(element, validator: validator);
      } else {
        debugPrint("$element is not a valid script");
      }
    });
  }

  // Setup the `JitsiMeetExternalAPI` JS script
  void _setupScripts() {
    final html.ScriptElement script = html.ScriptElement()
      ..appendText(_clientJs());
    html.querySelector('head').children.add(script);
  }

  // Script to allow Jitsi interaction
  // To allow Flutter interact with `JitsiMeetExternalAPI`
  // extends and override the constructor is needed
  String _clientJs() => """
class JitsiMeetAPI extends JitsiMeetExternalAPI {
    constructor(domain , options) {
      console.log(options);
      var _options = JSON.parse(options);
      if (!_options.hasOwnProperty("width")) {
        _options.width='100%';
      }
      if (!_options.hasOwnProperty("height")) {
        _options.height='100%';
      }
      // override parent to atach to view
      //_options.parentNode=document.getElementsByTagName('flt-platform-vw')[0].shadowRoot.getElementById('jitsi-meet-section');
      console.log(_options);
      _options.parentNode=document.querySelector("#jitsi-meet-section");
      super(domain, _options);
    }
}
var jitsi = { JitsiMeetAPI: JitsiMeetAPI };""";
}
