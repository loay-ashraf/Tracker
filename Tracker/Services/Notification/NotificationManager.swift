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
    
    private let center = UNUserNotificationCenter.current()
    private var authorizationStatus: UNAuthorizationStatus {
        get async {
            return await center.notificationSettings().authorizationStatus
        }
    }
    
    // MARK: - Initialization
    
    private override init() { super.init() }
    
    // MARK: - Setup Method
    
    func setup() async throws {
        center.delegate = self
        guard await authorizationStatus != .denied else {
            throw NotificationError.notificationAccessDenied
        }
        if await authorizationStatus == .notDetermined {
            let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
            do {
                try await center.requestAuthorization(options: authOptions)
            } catch {
                throw NotificationError.notificationAuthorizationError(error)
            }
        }
    }
    
    // MARK: - Notification Methods
    
    func sendNotification(notification: Notification) {
        DispatchQueue.main.async {
            guard UIApplication.shared.applicationState == .background else {
                return
            }
            UIApplication.incrementAppBadgeNumber(byValue: 1)
            self.center.add(notification.request, withCompletionHandler: nil)
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
