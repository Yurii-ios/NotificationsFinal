//
//  AppDelegate.swift
//  Notifications
//

//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notifications = Notifications()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        notifications.requestAutorization()
        notifications.notificationCenter.delegate = notifications
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken
        deviceToken: Data) {
        
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device token: \(token)")
    }
    
    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError
        error: Error) {
        
        print("Failed to register: \(error)")
    }
    // otkruwaem Settings.storyboard
    func openSettings() {
        // sozdaem ekzempliar klasa
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        // sozdaem ekzempliar viewControllera
        let settings = storyboard.instantiateViewController(withIdentifier: "Settings")
        // nazna4aem sozdanuj viewControler w ka4estwe glawnogo 
        window?.rootViewController = settings
    }
}
