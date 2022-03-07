//
//  NotificationTypes.swift
//  Tracker
//
//  Created by Loay Ashraf on 04/03/2022.
//

import UIKit
import NotificationBannerSwift

enum Notification {
    
    case locationUpdated(String)
    
    var request: UNNotificationRequest {
        switch self {
        case .locationUpdated(let body): return NotificationConstants.LocationUpdated.notificationRequest(body: body)
        }
    }
    
    var banner: FloatingNotificationBanner {
        switch self {
        case .locationUpdated(let subtitle): return NotificationConstants.LocationUpdatedBanner.notificationBanner(subtitle: subtitle)
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
