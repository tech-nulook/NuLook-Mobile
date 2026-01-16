//package com.affluora.nulook.app.nulook_app
//
//import android.Manifest
//import android.annotation.SuppressLint
//import android.content.Context
//import android.content.pm.PackageManager
//import android.location.Location
//import android.location.LocationListener
//import android.location.LocationManager
//import androidx.core.app.ActivityCompat
//import io.flutter.plugin.common.EventChannel
//
//class LocationStreamHandler(private val context: Context) : EventChannel.StreamHandler {
//
//    private var locationManager: LocationManager? = null
//    private var listener: LocationListener? = null
//
//    @SuppressLint("MissingPermission")
//    override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
//        locationManager = context.getSystemService(Context.LOCATION_SERVICE) as LocationManager
//
//        listener = LocationListener { location: Location ->
//            val data = mapOf(
//                "latitude" to location.latitude,
//                "longitude" to location.longitude
//            )
//            events.success(data)
//        }
//
//        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.ACCESS_FINE_LOCATION)
//            == PackageManager.PERMISSION_GRANTED) {
//            locationManager?.requestLocationUpdates(
//                LocationManager.GPS_PROVIDER,
//                2000L, // 2 seconds
//                0f,
//                listener!!
//            )
//        } else {
//            events.error("PERMISSION_DENIED", "Location permission not granted", null)
//        }
//    }
//
//    override fun onCancel(arguments: Any?) {
//        listener?.let {
//            locationManager?.removeUpdates(it)
//        }
//    }
//}