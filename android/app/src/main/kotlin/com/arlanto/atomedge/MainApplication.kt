package com.arlanto.atomedge

import android.app.Application
import android.util.Log

// ─── Intune MAM SDK Integration ──────────────────────────────────────────────
// When the Microsoft Maven feed is authenticated and the SDK dependency is
// uncommented in build.gradle, change the base class to MAMApplication:
//
//   import com.microsoft.intune.mam.client.app.MAMApplication
//   class MainApplication : MAMApplication() { ... }
//
// MAMApplication hooks into the Android Application lifecycle so that the
// Intune SDK can:
//   - Enforce App Protection Policies (copy/paste, screenshot, save-as)
//   - Handle device enrollment with Company Portal / Microsoft Authenticator
//   - Receive and act on WIPE_USER_DATA events from the Intune portal
//   - Report compliance status to Azure AD Conditional Access
//
// No other code changes in MainApplication are needed beyond changing the base.
// The MAM build plugin (com.microsoft.intune.mam) handles Activity wrapping.
// ─────────────────────────────────────────────────────────────────────────────

/**
 * Application entry point.
 *
 * Currently extends plain [Application]. Switch to [MAMApplication] once the
 * Intune MAM SDK dependency is available (see comment block above).
 */
class MainApplication : Application() {

    companion object {
        private const val TAG = "MainApplication"
    }

    override fun onCreate() {
        super.onCreate()
        Log.d(TAG, "MainApplication.onCreate")
        // MAM SDK initialises automatically via MAMApplication.onCreate() once
        // the base class is switched — no explicit SDK init call is needed here.
    }
}
