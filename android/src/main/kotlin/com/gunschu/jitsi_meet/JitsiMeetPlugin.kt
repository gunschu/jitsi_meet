package com.gunschu.jitsi_meet

import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.jitsi.meet.sdk.JitsiMeetActivity
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions
import org.jitsi.meet.sdk.JitsiMeetUserInfo
import java.net.URL


/** JitsiMeetPlugin */
public class JitsiMeetPlugin() : FlutterPlugin, MethodCallHandler, ActivityAware {
    val JITSI_PLUGIN_TAG = "JITSI_MEET_PLUGIN"

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private var activity: Activity? = null

    constructor(activity: Activity) : this() {
        this.activity = activity
    }

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "jitsi_meet")
        channel.setMethodCallHandler(this)
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
            val channel = MethodChannel(registrar.messenger(), "jitsi_meet")
            channel.setMethodCallHandler(JitsiMeetPlugin(registrar.activity()))
        }
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Log.d(JITSI_PLUGIN_TAG, "method: ${call.method}")
        Log.d(JITSI_PLUGIN_TAG, "arguments: ${call.arguments}")

        when (call.method) {
            "joinMeeting" -> {
                joinMeeting(call, result)
            }
            "joinMeetingWithOptions" -> {
                val room = call.argument<String>("roomName")
                joinMeetingWithOptions(room, result)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun joinMeeting(call: MethodCall, result: Result) {
        var room = call.argument<String>("room")
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

        val serverURLString = call.argument<String>("serverURL")
//        var serverURL : URL? = null
        if (serverURLString != null) {
//            serverURL = URL(serverURLString)
//            Log.d(TAG, "Server URL: $serverURL, $serverURLString")
            // TODO remove the following and uncomment code above after android sdk fixed
            room = "$serverURLString/$room"
        }

        // Build options object for joining the conference. The SDK will merge the default
        // one we set earlier and this one when joining.
        val options = JitsiMeetConferenceOptions.Builder()
                .setRoom(room)
//                .setServerURL(serverURL) TODO: use serverURL after android SDK is fixed: https://github.com/jitsi/jitsi-meet/issues/5504#issue-590910863
                .setSubject(call.argument("subject"))
                .setToken(call.argument("token"))
                .setAudioMuted(call.argument("audioMuted") ?: false)
                .setAudioOnly(call.argument("audioOnly") ?: false)
                .setVideoMuted(call.argument("videoMuted") ?: false)
                .setUserInfo(userInfo)
                .build()

        // Launch the new activity with the given options. The launch() method takes care
        // of creating the required Intent and passing the options.
        JitsiMeetActivity.launch(activity, options)
        result.success("Successful joined room: $room")
    }

    fun joinMeetingWithOptions(room: String?, result: Result) {
        if (room.isNullOrBlank()) {
            result.error("400",
                    "room can not be null or empty",
                    "room can not be null or empty")
            return
        }

        Log.d("JITSI_MEET", "Building Room: $room")

        // Build options object for joining the conference. The SDK will merge the default
        // one we set earlier and this one when joining.
        val options = JitsiMeetConferenceOptions.Builder()
                .setRoom(room)
                .build()

        // Launch the new activity with the given options. The launch() method takes care
        // of creating the required Intent and passing the options.
        JitsiMeetActivity.launch(activity, options)
        result.success("Successful joined room: $room")
    }

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
