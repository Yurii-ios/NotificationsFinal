//
//  NotificationViewController.swift
//  NotificationContent
//

//

import UIKit
import UserNotifications
import UserNotificationsUI

// add to plist w NSExtension -> NSExtensionAttributes + UNNotificationExtensionUserInteractionEnabled, UNNotificationExtensionDefaultContentHidden

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var label: UILabel?
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNotificationCategories()
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        likeButton.setTitle("♥", for: .normal)
    }
    
    @IBAction func openAppButton(_ sender: Any) {
        openApp()
    }
    
    
    func openApp() {
        extensionContext?.performNotificationDefaultAction()
    }
    
    func dismissNotification() {
        extensionContext?.dismissNotificationContentExtension()
    }
    //  metod UNNotificationContentExtension, kotoruj pozwoliae rabotat s kontentom ywedomlenij
    func didReceive(_ notification: UNNotification) {
        label?.text = notification.request.content.body
    }
    // nastraiwaem polzowatelskie dejstwija dlia ywedomlenij
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        switch response.actionIdentifier {
        case "Snooze":
            let actions = [
                UNNotificationAction(identifier: "5 second",  title: "Отложить на 5 секунд", options: []),
                UNNotificationAction(identifier: "10 second",  title: "Отложить на 10 секунд", options: []),
                UNNotificationAction(identifier: "60 second",  title: "Отложить на 60 секунд", options: []),
                ]
            extensionContext?.notificationActions = actions
        case "5 second":
            reminder(timeInterval: 5)
            dismissNotification()
        case "10 second":
            reminder(timeInterval: 10)
            dismissNotification()
        case "60 second":
            reminder(timeInterval: 60)
            dismissNotification()
        case "Dismiss":
            dismissNotification()
        default:
            dismissNotification()
        }
    }
    
    func reminder(timeInterval: Double) {
        
        let content = UNMutableNotificationContent()
        
        content.title = "Reminder"
        content.body = "Summer Time"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "User Actions"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let uuid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuid,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
   // propisuwaem menu polzowatelskich dejstwij
    func setNotificationCategories() {
        
        let actions = [
            UNNotificationAction(identifier: "Snooze",  title: "Snooze", options: []),
            UNNotificationAction(identifier: "Dismiss",  title: "Dismiss", options: [.destructive]),
            ]
        // %u - otwe4aet za koli4estwo soobs4enij w grype, egomožno modeficurowat s pomos4jy symmery argyment count( zna4enie peremennoj - %@)
        let category = UNNotificationCategory(identifier: "User Actions",
                                              actions: actions,
                                              intentIdentifiers: [],
                                              hiddenPreviewsBodyPlaceholder: nil,
                                              categorySummaryFormat: "%u новых уведомлений в разделе %@",
                                              options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}
