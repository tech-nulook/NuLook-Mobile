import Flutter
import UIKit
import GoogleMaps
import CoreLocation
import flutter_local_notifications
import FirebaseCore

@main
@objc class AppDelegate: FlutterAppDelegate, CLLocationManagerDelegate {
    private let CHANNEL = "samples.flutter.dev/locationStream"
    private var eventSink: FlutterEventSink?
    private var locationManager: CLLocationManager?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    // This is required to make any communication available in the action isolate.
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
        GeneratedPluginRegistrant.register(with: registry)
    }
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)
    
    UNUserNotificationCenter.current().delegate = self
    GMSServices.provideAPIKey("AIzaSyDoflvhg2GsC47ZZUKKAefnwbcDIApTAT0")

    let controller = window?.rootViewController as! FlutterViewController
    let eventChannel = FlutterEventChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)
    eventChannel.setStreamHandler(self)
    locationManager = CLLocationManager()
    locationManager?.delegate = self
    locationManager?.requestWhenInUseAuthorization()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
     guard let loc = locations.last else { return }
     eventSink?(["latitude": loc.coordinate.latitude, "longitude": loc.coordinate.longitude])
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
     print("Location error: \(error)")
  }
}

extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        locationManager?.startUpdatingLocation()
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        locationManager?.stopUpdatingLocation()
        eventSink = nil
        return nil
    }
}
