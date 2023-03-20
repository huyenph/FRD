package com.hpcompose.frd

import android.Manifest.permission.POST_NOTIFICATIONS
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channelName = "com.hpcompose.frd/notification"
    private lateinit var channel: MethodChannel

//    @RequiresApi(33)
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channelName
        ).setMethodCallHandler { call, result ->
            if (call.method == "postNotificationPermission") {
                if (ContextCompat.checkSelfPermission(
                        this,
                        POST_NOTIFICATIONS
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    if (Build.VERSION.SDK_INT >= 33) {
//                        Toast.makeText(this, "post notification", Toast.LENGTH_LONG).show()
                        ActivityCompat.requestPermissions(this, arrayOf(POST_NOTIFICATIONS), 1)
                    }
//            requestPermissionLauncher.launch(Manifest.permission.POST_NOTIFICATIONS)
                }
            }

        }
//        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
//        channel.setMethodCallHandler { call, _ ->
//            if (call.method == "postNotificationPermission") {
//                if (ContextCompat.checkSelfPermission(
//                        this,
//                        POST_NOTIFICATIONS
//                    ) != PackageManager.PERMISSION_GRANTED
//                ) {
//                    ActivityCompat.requestPermissions(this, arrayOf(POST_NOTIFICATIONS), 1)
////            requestPermissionLauncher.launch(Manifest.permission.POST_NOTIFICATIONS)
//                }
//            }
//        }
    }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
    }

}