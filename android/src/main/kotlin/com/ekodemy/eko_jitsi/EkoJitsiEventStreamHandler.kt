package com.ekodemy.eko_jitsi

import android.util.Log
import com.ekodemy.eko_jitsi.EkoJitsiPlugin.Companion.EKO_JITSI_TAG
import io.flutter.plugin.common.EventChannel
import java.io.Serializable

/**
 * StreamHandler to listen to conference events and broadcast it back to Flutter
 */
class EkoJitsiEventStreamHandler private constructor(): EventChannel.StreamHandler, Serializable {
    companion object {
        val instance = EkoJitsiEventStreamHandler()
    }

    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        Log.d(EKO_JITSI_TAG, "EkoJitsiEventStreamHandler.onListen")
        this.eventSink = eventSink
    }

    override fun onCancel(arguments: Any?) {
        Log.d(EKO_JITSI_TAG, "EkoJitsiEventStreamHandler.onCancel")
        eventSink = null
    }

    fun onConferenceWillJoin(data: MutableMap<String, Any>?) {
        Log.d(EKO_JITSI_TAG, "EkoJitsiEventStreamHandler.onConferenceWillJoin")
        data?.put("event", "onConferenceWillJoin")
        eventSink?.success(data)
    }

    fun onConferenceJoined(data: MutableMap<String, Any>?) {
        Log.d(EKO_JITSI_TAG, "EkoJitsiEventStreamHandler.onConferenceJoined")
        data?.put("event", "onConferenceJoined")
        eventSink?.success(data)
    }

    fun onConferenceTerminated(data: MutableMap<String, Any>?) {
        Log.d(EKO_JITSI_TAG, "EkoJitsiEventStreamHandler.onConferenceTerminated")
        data?.put("event", "onConferenceTerminated")
        eventSink?.success(data)
    }

    fun onParticipantLeft(data: MutableMap<String, Any>?) {
        Log.d(EKO_JITSI_TAG, "EkoJitsiEventStreamHandler.onParticipantLeft")
        data?.put("event", "onParticipantLeft")
        eventSink?.success(data)
    }

    fun onPictureInPictureWillEnter() {
        Log.d(EKO_JITSI_TAG, "JitsiMeetEventStreamHandler.onPictureInPictureWillEnter")
        var data : HashMap<String, String>
                = HashMap<String, String> ()
        data?.put("event", "onPictureInPictureWillEnter")
        eventSink?.success(data)
    }

    fun onPictureInPictureTerminated() {
        Log.d(EKO_JITSI_TAG, "JitsiMeetEventStreamHandler.onPictureInPictureTerminated")
        var data : HashMap<String, String>
                = HashMap<String, String> ()
        data?.put("event", "onPictureInPictureTerminated")
        eventSink?.success(data)
    }

    

}