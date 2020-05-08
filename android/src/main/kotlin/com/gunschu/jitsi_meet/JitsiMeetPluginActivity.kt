package com.gunschu.jitsi_meet

import android.content.Context
import android.content.Intent
import android.util.Log
import com.gunschu.jitsi_meet.JitsiMeetPlugin.Companion.JITSI_PLUGIN_TAG
import org.jitsi.meet.sdk.JitsiMeetActivity
import org.jitsi.meet.sdk.JitsiMeetConferenceOptions
import android.content.res.Configuration

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

    var onStopCalled: Boolean = false;

    override fun onPictureInPictureModeChanged( isInPictureInPictureMode: Boolean, newConfig: Configuration?)
    {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)

        if (isInPictureInPictureMode == false && onStopCalled)
        {
            // Picture-in-Picture mode has been closed, we can (should !) end the call
            getJitsiView().leave()
        }
    }

    override fun onStop()
    {
        super.onStop()
        onStopCalled = true;
    }

    override fun onResume()
    {
        super.onResume()
        onStopCalled = false;
    }

    override fun onConferenceWillJoin(data: MutableMap<String, Any>?) {
        Log.d(JITSI_PLUGIN_TAG, String.format("JitsiMeetPluginActivity.onConferenceWillJoin: %s", data))
        JitsiMeetEventStreamHandler.instance.onConferenceWillJoin(data)
        super.onConferenceWillJoin(data)
    }

    override fun onConferenceJoined(data: MutableMap<String, Any>?) {
        Log.d(JITSI_PLUGIN_TAG, String.format("JitsiMeetPluginActivity.onConferenceJoined: %s", data))
        JitsiMeetEventStreamHandler.instance.onConferenceJoined(data)
        super.onConferenceJoined(data)
    }

    override fun onConferenceTerminated(data: MutableMap<String, Any>?) {

        Log.d(JITSI_PLUGIN_TAG, String.format("JitsiMeetPluginActivity.onConferenceTerminated: %s", data))
        JitsiMeetEventStreamHandler.instance.onConferenceTerminated(data)
        super.onConferenceTerminated(data)
    }
}