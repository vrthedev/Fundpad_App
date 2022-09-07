import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      
      UNUserNotificationCenter.current().delegate = self
      let center = UNUserNotificationCenter.current()
      center.requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in

          // If granted comes true you can enabled features based on authorization.
          guard granted else { return }
          DispatchQueue.main.async {
              application.registerForRemoteNotifications()
          }
      }
      
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
      {
          completionHandler([.alert, .badge, .sound])
      }
}
