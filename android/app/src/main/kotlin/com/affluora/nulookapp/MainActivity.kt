package com.affluora.nulookapp

import io.flutter.embedding.android.FlutterActivity
import android.Manifest
import android.annotation.SuppressLint
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.os.Build
import android.os.Bundle
import android.view.WindowManager
import androidx.core.app.ActivityCompat
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/locationStream"
    private var locationManager: LocationManager? = null
    private var listener: LocationListener? = null

    @SuppressLint("MissingPermission")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        if(Build.VERSION.SDK_INT > 36){
            window.setFlags(
                WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
                WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            )
        }

        // Register location stream handler
//        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
//            .setStreamHandler(LocationStreamHandler(this))

    }
}
