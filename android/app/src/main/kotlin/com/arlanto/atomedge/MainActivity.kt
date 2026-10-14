//package com.arlanto.atomedge
//
//import io.flutter.embedding.android.FlutterActivity
//
//class MainActivity: FlutterActivity() {
//}

package com.arlanto.atomedge

import android.content.SharedPreferences
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// ─── Intune MAM SDK Notification Imports ─────────────────────────────────────
// Uncomment once MAM SDK dependency is added to build.gradle:
//
// import com.microsoft.intune.mam.client.notification.MAMNotificationReceiverRegistry
// import com.microsoft.intune.mam.client.notification.MAMNotificationType
// import com.microsoft.intune.mam.policy.MAMEnrollmentNotification
//
// Also: the MAM build plugin transforms FlutterActivity → MAMAppCompatActivity
// at compile time, so no base class change is needed in this file.
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Main Flutter Activity.
 *
 * Responsibilities beyond the standard Flutter embedding:
 *  1. Exposes a MethodChannel ([MAM_CHANNEL]) that the Dart layer uses to
 *     receive Intune MAM events (selective wipe, enrollment result, etc.).
 *  2. Registers for MAM notifications once the SDK is added (see commented
 *     block [registerForMAMNotifications]).
 *  3. On WIPE_USER_DATA: clears [FlutterSharedPreferences] and signals the
 *     Dart layer to navigate to the login screen.
 */
class MainActivity : FlutterActivity() {

    companion object {
        private const val TAG = "MainActivity"

        /**
         * Method channel name — must match [_mamChannel] in main_config.dart exactly.
         */
        const val MAM_CHANNEL = "com.arlanto.atomedge/mam"
    }

    private var flutterMethodChannel: MethodChannel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        // registerForMAMNotifications()   ← uncomment when MAM SDK is added
        Log.d(TAG, "onCreate")
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterMethodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            MAM_CHANNEL
        )
        flutterMethodChannel?.setMethodCallHandler { call, result ->
            when (call.method) {
                "getAndroidId" -> {
                    val androidId = android.provider.Settings.Secure.getString(
                        contentResolver,
                        android.provider.Settings.Secure.ANDROID_ID
                    )
                    result.success(androidId)
                }
                else -> result.notImplemented()
            }
        }
        Log.d(TAG, "MAM MethodChannel registered")
    }

    // -------------------------------------------------------------------------
    // MAM notification handler — activate with SDK
    // -------------------------------------------------------------------------

    /**
     * Registers for Intune MAM lifecycle notifications.
     *
     * Call this from [onCreate] once `com.microsoft.intune.mam.client:intune-mam-sdk`
     * is added to dependencies. No other changes are required.
     *
     * Notifications handled:
     *  - [MAMNotificationType.MAM_ENROLLMENT_RESULT] — enrollment completed/failed.
     *  - [MAMNotificationType.WIPE_USER_DATA]       — IT admin wiped the app.
     *  - [MAMNotificationType.REFRESH_APP_CONFIG]   — policy config refreshed.
     */
    @Suppress("unused")
    private fun registerForMAMNotifications() {
        // MAMNotificationReceiverRegistry.instance.registerReceiver(
        //     { notification ->
        //         when (notification.type) {
        //
        //             MAMNotificationType.MAM_ENROLLMENT_RESULT -> {
        //                 val enrollmentNotification = notification as? MAMEnrollmentNotification
        //                 Log.d(TAG, "MAM enrollment result: ${enrollmentNotification?.enrollmentResult}")
        //                 true
        //             }
        //
        //             MAMNotificationType.WIPE_USER_DATA -> {
        //                 Log.w(TAG, "WIPE_USER_DATA — clearing app data")
        //                 clearLocalAppData()
        //                 runOnUiThread {
        //                     flutterMethodChannel?.invokeMethod("onIntuneWipe", null)
        //                 }
        //                 true   // returning true = we handled the wipe
        //             }
        //
        //             MAMNotificationType.REFRESH_APP_CONFIG -> {
        //                 Log.d(TAG, "MAM app config refreshed")
        //                 true
        //             }
        //
        //             else -> true
        //         }
        //     },
        //     MAMNotificationType.MAM_ENROLLMENT_RESULT,
        //     MAMNotificationType.WIPE_USER_DATA,
        //     MAMNotificationType.REFRESH_APP_CONFIG
        // )
    }

    /**
     * Clears the Flutter layer's SharedPreferences partition.
     * Called on WIPE_USER_DATA so no tokens or user data remain on device.
     */
    private fun clearLocalAppData() {
        try {
            val prefs: SharedPreferences =
                getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
            prefs.edit().clear().apply()
            Log.d(TAG, "FlutterSharedPreferences cleared")
        } catch (e: Exception) {
            Log.e(TAG, "Error clearing app data: ${e.message}")
        }
    }
}
