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
    }
    
    func requestAuthorization() async throws -> UNAuthorizationStatus {
        if await authorizationStatus == .notDetermined {
            let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
            do {
                try await center.requestAuthorization(options: authOptions)
                
            } catch {
                throw NotificationError.notificationAuthorizationError(error)
            }
        }
        return await authorizationStatus
    }
    
    // MARK: - Notification Methods
    
    func sendNotification(notification: Notification) {
        DispatchQueue.main.async {
            if UIApplication.shared.applicationState == .background {
                UIApplication.incrementAppBadgeNumber(byValue: 1)
                self.center.add(notification.request, withCompletionHandler: nil)
            } else if UIApplication.shared.applicationState == .active, UIApplication.currentTabBarController()?.selectedIndex == 1 {
                notification.banner.show(cornerRadius: 10,
                                         shadowBlurRadius: 16,
                                         shadowEdgeInsets: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
            }
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
        NavigationRouter.showTab(withIndex: 1)
    }
    
}
