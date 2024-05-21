package com.optimus.eds_survey

import android.os.Bundle
import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.optimus.time/autoTime"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        flutterEngine?.let {
            MethodChannel(it.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "isAutoDateTimeEnabled") {
                    val isAutoTimeEnabled = isAutoDateTimeEnabled()
                    result.success(isAutoTimeEnabled)
                } else {
                    result.notImplemented()
                }
            }
        }
    }

    private fun isAutoDateTimeEnabled(): Boolean {
        return try {
            val autoTimeEnabled = Settings.Global.getInt(contentResolver, Settings.Global.AUTO_TIME) == 1
            val autoTimeZoneEnabled = Settings.Global.getInt(contentResolver, Settings.Global.AUTO_TIME_ZONE) == 1
            autoTimeEnabled && autoTimeZoneEnabled
        } catch (e: Settings.SettingNotFoundException) {
            false
        }
    }
}
