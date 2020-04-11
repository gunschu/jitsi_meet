package com.gunschu.jitsi_meet

import android.util.Log
import com.gunschu.jitsi_meet.JitsiMeetPlugin.Companion.JITSI_PLUGIN_TAG
import io.flutter.plugin.common.EventChannel
import java.io.Serializable

/**
 * StreamHandler to listen to conference events and broadcast it back to Flutter
 */
class JitsiMeetEventStreamHandler private constructor(): EventChannel.StreamHandler, Serializable {
    companion object {
        val instance = JitsiMeetEventStreamHandler()
    }

    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiMeetEventStreamHandler.onListen")
        this.eventSink = eventSink
    }

    override fun onCancel(arguments: Any?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiMeetEventStreamHandler.onCancel")
        eventSink = null
    }

    fun onConferenceWillJoin() {
        Log.d(JITSI_PLUGIN_TAG, "JitsiMeetEventStreamHandler.onConferenceWillJoin")
        eventSink?.success("onConferenceWillJoin")
    }

    fun onConferenceJoined() {
        Log.d(JITSI_PLUGIN_TAG, "JitsiMeetEventStreamHandler.onConferenceJoined")
        eventSink?.success("onConferenceJoined")
    }

    fun onConferenceTerminated() {
        Log.d(JITSI_PLUGIN_TAG, "JitsiMeetEventStreamHandler.onConferenceTerminated")
        eventSink?.success("onConferenceTerminated")
    }

}