package com.ekodemy.eko_jitsi

import android.app.KeyguardManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.res.Configuration
import android.graphics.Color
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.ViewGroup
import android.view.WindowManager
import android.widget.*
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import com.ekodemy.eko_jitsi.EkoJitsiPlugin.Companion.EKO_JITSI_CLOSE
import com.ekodemy.eko_jitsi.EkoJitsiPlugin.Companion.EKO_JITSI_TAG
import com.facebook.react.ReactRootView
import org.jitsi.meet.sdk.*
import java.util.*


/**
 * Activity extending JitsiMeetActivity in order to override the conference events
 */
class EkoJitsiPluginActivity : JitsiMeetActivity() {
    companion object {
        @JvmStatic
        fun launchActivity(
            context: Context?,
            options: JitsiMeetConferenceOptions
        ) {
            var intent = Intent(context, EkoJitsiPluginActivity::class.java).apply {
                action = "org.jitsi.meet.CONFERENCE"
                putExtra("JitsiMeetConferenceOptions", options)
            }
            context?.startActivity(intent)
        }
    }

    var onStopCalled: Boolean = false;

    override fun onPictureInPictureModeChanged(
        isInPictureInPictureMode: Boolean,
        newConfig: Configuration?
    ) {
        super.onPictureInPictureModeChanged(isInPictureInPictureMode, newConfig)
        if (isInPictureInPictureMode) {
            EkoJitsiEventStreamHandler.instance.onPictureInPictureWillEnter()
        } else {
            EkoJitsiEventStreamHandler.instance.onPictureInPictureTerminated()
        }
        if (isInPictureInPictureMode == false && onStopCalled) {
            // Picture-in-Picture mode has been closed, we can (should !) end the call
            getJitsiView().leave()
        }
    }

    private val myReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            when (intent?.action) {
                EKO_JITSI_CLOSE -> finish()
            }
        }
    }

    fun test() {
        try {
            var jitsiView: JitsiMeetView = jitsiView;
            Log.d(EKO_JITSI_TAG, "ABC " + jitsiView.javaClass.canonicalName);
            var ab = jitsiView.getRootReactView(jitsiView);
            Log.d(EKO_JITSI_TAG, "ABC " + ab.javaClass.canonicalName);
            var rootReactView: ReactRootView = ab as ReactRootView;
            Log.d(EKO_JITSI_TAG, "ABC " + rootReactView.javaClass.canonicalName);

        } catch (ex: Exception) {
            Log.e(EKO_JITSI_TAG, "ABC Error", ex);
        }
//        var jitsiFragment: Fragment? = getSupportFragmentManager().findFragmentById(R.id.jitsiFragment);
    }

    override fun onStop() {
        super.onStop()
        onStopCalled = true;
        unregisterReceiver(myReceiver)
    }

    override fun onResume() {
        super.onResume()
        onStopCalled = false
        registerReceiver(myReceiver, IntentFilter(EKO_JITSI_CLOSE))
    }

    override fun onConferenceWillJoin(data: HashMap<String, Any>?) {
        Log.d(EKO_JITSI_TAG, String.format("EkoJitsiPluginActivity.onConferenceWillJoin: %s", data))
        EkoJitsiEventStreamHandler.instance.onConferenceWillJoin(data)
        super.onConferenceWillJoin(data)
        this.test();
    }

    override fun onConferenceJoined(data: HashMap<String, Any>?) {
        Log.d(EKO_JITSI_TAG, String.format("EkoJitsiPluginActivity.onConferenceJoined: %s", data))
        EkoJitsiEventStreamHandler.instance.onConferenceJoined(data)
        super.onConferenceJoined(data)
    }

    override fun onConferenceTerminated(data: HashMap<String, Any>?) {

        Log.d(
            EKO_JITSI_TAG,
            String.format("EkoJitsiPluginActivity.onConferenceTerminated: %s", data)
        )
        EkoJitsiEventStreamHandler.instance.onConferenceTerminated(data)
        super.onConferenceTerminated(data)
    }

    override fun onParticipantLeft(data: HashMap<String, Any>?) {
        Log.d(EKO_JITSI_TAG, String.format("EkoJitsiPluginActivity.onParticipantLeft: %s", data))
        EkoJitsiEventStreamHandler.instance.onParticipantLeft(data)
        super.onConferenceTerminated(data)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        turnScreenOnAndKeyguardOff();
    }

    override fun onPostCreate(savedInstanceState: Bundle?) {
        Log.i(EKO_JITSI_TAG, "ABC Post Create");
        super.onPostCreate(savedInstanceState);
        logContentView(getWindow().getDecorView(), "");
        val view = window.decorView as ViewGroup;
        Log.d(EKO_JITSI_TAG, "ABC " + view.javaClass.canonicalName);
        val layout: LinearLayout = view.getChildAt(0) as LinearLayout;
        var ekoLayout: LinearLayout = LinearLayout(this);
        ekoLayout.gravity = Gravity.LEFT;

        val logoText = TextView(this);
        logoText.text = "Logo";
        logoText.id = View.generateViewId();
        var btnLayout: LinearLayout = LinearLayout(this);
        btnLayout.gravity = Gravity.RIGHT;
        val btnTag = Button(this)
        btnTag.text = "Button ABC";
        btnTag.id = View.generateViewId();
        ekoLayout.addView(logoText);
        btnLayout.addView(btnTag);
        ekoLayout.addView(btnLayout);
        btnTag.setOnClickListener {
            EkoJitsiEventStreamHandler.instance.onWhiteboardClicked();
        };
        layout.addView(ekoLayout, 0);
    }

    fun logContentView(parent: View, indent: String) {
        Log.i("ABC test", indent + parent.javaClass.name)
        if (parent is ViewGroup) {
            val group = parent
            for (i in 0 until group.childCount) logContentView(group.getChildAt(i), "$indent ")
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        turnScreenOffAndKeyguardOn();
    }

    private fun turnScreenOnAndKeyguardOff() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            // For newer than Android Oreo: call setShowWhenLocked, setTurnScreenOn
            setShowWhenLocked(true)
            setTurnScreenOn(true)

            // If you want to display the keyguard to prompt the user to unlock the phone:
            val keyguardManager = getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager
            keyguardManager?.requestDismissKeyguard(this, null)
        } else {
            // For older versions, do it as you did before.
            window.addFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
                        or WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
                        or WindowManager.LayoutParams.FLAG_FULLSCREEN
                        or WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
                        or WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
                        or WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON
            )
        }
    }

    private fun turnScreenOffAndKeyguardOn() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(false)
            setTurnScreenOn(false)
        } else {
            window.clearFlags(
                WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
                        or WindowManager.LayoutParams.FLAG_FULLSCREEN
                        or WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
                        or WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
                        or WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
                        or WindowManager.LayoutParams.FLAG_ALLOW_LOCK_WHILE_SCREEN_ON
            )
        }
    }
}

fun BaseReactView<JitsiMeetViewListener>.getRootReactView(view: JitsiMeetView): Any {

    return BaseReactView::class.java.getDeclaredField("reactRootView").let {
        it.isAccessible = true;
        val value = it.get(view);
        //todo
        return@let value;
    }

//    return this.reactRootView;
}
