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
    
    // MARK: - Properties
    
    static let standard = NotificationManager()
    
    private let manager = UNUserNotificationCenter.current()
    
    // MARK: - Initialization
    
    private override init() { super.init() }
    
    // MARK: - Setup Method
    
    func setup() {
        manager.delegate = self
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        manager.requestAuthorization(options: authOptions, completionHandler: { success,error in })
    }
    
    // MARK: - Notification Methods
    
    func sendNotification(notification: Notification) {
        DispatchQueue.main.async {
            guard UIApplication.shared.applicationState == .background else {
                return
            }
            UIApplication.incrementAppBadgeNumber(byValue: 1)
            self.manager.add(notification.request, withCompletionHandler: nil)
        }
    }
    
    func resetNotificationBadge() {
        DispatchQueue.main.async {
            UIApplication.resetAppBadgeNumber()
        }
    }
    
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    
    // MARK: - Notification Center Delegate
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        resetNotificationBadge()
        NavigationRouter.showTab(withIndex: 1)
    }
    
}
