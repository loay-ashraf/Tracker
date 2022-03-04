//
//  NotificationTypes.swift
//  Tracker
//
//  Created by Loay Ashraf on 04/03/2022.
//

import UIKit

enum Notification {
    
    case locationUpdated(String)
    
    var request: UNNotificationRequest {
        switch self {
        case .locationUpdated(let body): return NotificationConstants.LocationChanged.notificationRequest(body: body)
        }
    }
    
}

enum NotificationError: Error {
    
    case notificationAccessDenied
    case notificationAuthorizationError(Error)
    
    func alert(handler: (() -> Void)? = nil) -> Alert? {
        switch self {
        case .notificationAccessDenied: return Alert.notificationAccessDenied(handler)
        case .notificationAuthorizationError: return Alert.notificationAuthorizationError(handler)
        }
    }
    
}
