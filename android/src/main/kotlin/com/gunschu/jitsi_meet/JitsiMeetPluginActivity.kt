package com.gunschu.jitsi_meet

import android.content.Context
import android.content.Intent
import android.util.Log
import com.gunschu.jitsi_meet.JitsiMeetPlugin.Companion.JITSI_PLUGIN_TAG
import org.jitsi.meet.sdk.JitsiMeetActivity
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions

/**
 * Activity extending JitsiMeetActivity in order to override the conference events
 */
class JitsiMeetPluginActivity: JitsiMeetActivity() {
    companion object {
        @JvmStatic
        fun launchActivity(context: Context?,
                           options: JitsiMeetConferenceOptions) {
            var intent = Intent(context, JitsiMeetPluginActivity::class.java).apply {
                action = "org.jitsi.meet.CONFERENCE"
                putExtra("JitsiMeetConferenceOptions", options)
            }
            context?.startActivity(intent)
        }
    }
    
    override fun onConferenceWillJoin(data: MutableMap<String, Any>?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiMeetPluginActivity.onConferenceWillJoin")
        JitsiMeetEventStreamHandler.instance.onConferenceWillJoin()
        super.onConferenceWillJoin(data)
    }

    override fun onConferenceJoined(data: MutableMap<String, Any>?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiMeetPluginActivity.onConferenceJoined")
        JitsiMeetEventStreamHandler.instance.onConferenceJoined()
        super.onConferenceJoined(data)
    }

    override fun onConferenceTerminated(data: MutableMap<String, Any>?) {
        Log.d(JITSI_PLUGIN_TAG, "JitsiMeetPluginActivity.onConferenceTerminated")
        JitsiMeetEventStreamHandler.instance.onConferenceTerminated()
        super.onConferenceTerminated(data)
    }
}