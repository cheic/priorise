package sn.smapp.priorise

import android.app.UiModeManager
import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "sn.smapp.priorise/theme"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setTheme") {
                val theme = call.argument<String>("theme")
                setNativeTheme(theme)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun setNativeTheme(theme: String?) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            val uiManager = getSystemService(Context.UI_MODE_SERVICE) as UiModeManager
            when (theme) {
                "light" -> uiManager.setApplicationNightMode(UiModeManager.MODE_NIGHT_NO)
                "dark" -> uiManager.setApplicationNightMode(UiModeManager.MODE_NIGHT_YES)
                else -> uiManager.setApplicationNightMode(UiModeManager.MODE_NIGHT_AUTO)
            }
        }
    }
}
