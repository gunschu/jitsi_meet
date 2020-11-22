package com.gunschu.jitsi_meet

import android.app.Activity
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions
import org.jitsi.meet.sdk.JitsiMeetUserInfo
import java.net.URL


/** JitsiMeetPlugin */
public class JitsiMeetPlugin() : FlutterPlugin, MethodCallHandler, ActivityAware {

    // The MethodChannel that will hold the communication between Flutter and native Android
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    // The EventChannel for broadcasting JitsiMeetEvents to Flutter
    private lateinit var eventChannel: EventChannel

    private var activity: Activity? = null

    constructor(activity: Activity) : this() {
        this.activity = activity
    }

    /**
     * FlutterPlugin interface implementations
     */
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, JITSI_METHOD_CHANNEL)
        channel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, JITSI_EVENT_CHANNEL)
        eventChannel.setStreamHandler(JitsiMeetEventStreamHandler.instance)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val plugin = JitsiMeetPlugin(registrar.activity())
            val channel = MethodChannel(registrar.messenger(), JITSI_METHOD_CHANNEL)
            channel.setMethodCallHandler(plugin)


            val eventChannel = EventChannel(registrar.messenger(), JITSI_EVENT_CHANNEL)
            eventChannel.setStreamHandler(JitsiMeetEventStreamHandler.instance)
        }

        const val JITSI_PLUGIN_TAG = "JITSI_MEET_PLUGIN"
        const val JITSI_METHOD_CHANNEL = "jitsi_meet"
        const val JITSI_EVENT_CHANNEL = "jitsi_meet_events"
        const val JITSI_MEETING_CLOSE = "JITSI_MEETING_CLOSE"
    }

    /**
     * MethodCallHandler interface implementations
     */
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d(JITSI_PLUGIN_TAG, "method: ${call.method}")
        Log.d(JITSI_PLUGIN_TAG, "arguments: ${call.arguments}")

        when (call.method) {
            "joinMeeting" -> {
                joinMeeting(call, result)
            }
            "closeMeeting" -> {
                closeMeeting(call, result)
            }
            else -> result.notImplemented()
        }
    }

    /**
     * Method call to join a meeting
     */
    private fun joinMeeting(call: MethodCall, result: Result) {
        val room = call.argument<String>("room")
        if (room.isNullOrBlank()) {
            result.error("400",
                    "room can not be null or empty",
                    "room can not be null or empty")
            return
        }

        Log.d(JITSI_PLUGIN_TAG, "Joining Room: $room")

        val userInfo = JitsiMeetUserInfo()
        userInfo.displayName = call.argument("userDisplayName")
        userInfo.email = call.argument("userEmail")
        if (call.argument<String?>("userAvatarURL") != null) {
            userInfo.avatar = URL(call.argument("userAvatarURL"))
        }

        var serverURLString = call.argument<String>("serverURL")
        if (serverURLString == null) {
            serverURLString = "https://meet.jit.si";
        }
        val serverURL = URL(serverURLString)
        Log.d(JITSI_PLUGIN_TAG, "Server URL: $serverURL, $serverURLString")

        val optionsBuilder = JitsiMeetConferenceOptions.Builder()

        // Set meeting options
        optionsBuilder
                .setServerURL(serverURL)
                .setRoom(room)
                .setSubject(call.argument("subject"))
                .setToken(call.argument("token"))
                .setAudioMuted(call.argument("audioMuted") ?: false)
                .setAudioOnly(call.argument("audioOnly") ?: false)
                .setVideoMuted(call.argument("videoMuted") ?: false)
                .setUserInfo(userInfo)

        // Add feature flags into options, reading given Map
        if (call.argument<HashMap<String, Any>?>("featureFlags") != null) {
            val featureFlags = call.argument<HashMap<String, Any>>("featureFlags")
            featureFlags!!.forEach { (key, value) ->
                if (value is Boolean) {
                    val boolVal = value.toString().toBoolean()
                    optionsBuilder.setFeatureFlag(key, boolVal)
                } else {
                    val intVal = value.toString().toInt()
                    optionsBuilder.setFeatureFlag(key, intVal)
                }
            }
        }

        // Build with meeting options and feature flags
        val options = optionsBuilder.build()

        JitsiMeetPluginActivity.launchActivity(activity, options)
        result.success("Successfully joined room: $room")
    }

    private fun closeMeeting(call: MethodCall, result: Result) {
        val intent = Intent(JITSI_MEETING_CLOSE)
        activity?.sendBroadcast(intent)
        result.success(null)
    }

    /**
     * ActivityAware interface implementations
     */
    override fun onDetachedFromActivity() {
        this.activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        onAttachedToActivity(binding)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity()
    }


}
