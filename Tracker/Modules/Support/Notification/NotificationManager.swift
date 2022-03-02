//
//  NotificationManager.swift
//  Tracker
//
//  Created by Loay Ashraf on 02/03/2022.
//

import Foundation
import UserNotifications
import UIKit

class NotificationManager: NSObject {
    
    static let standard = NotificationManager()
    
    private let manager = UNUserNotificationCenter.current()
    private var notificationCount = 0
    
    private override init() { super.init() }
    
    func setup() {
        manager.delegate = self
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        manager.requestAuthorization(options: authOptions, completionHandler: { success,error in })
    }
    
    func sendNotification(notification: Notification) {
        guard UIApplication.shared.applicationState == .background else {
            return
        }
        notificationCount += 1
        UIApplication.shared.applicationIconBadgeNumber = notificationCount
        manager.add(notification.request, withCompletionHandler: nil)
    }
    
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        notificationCount = 0
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
}
