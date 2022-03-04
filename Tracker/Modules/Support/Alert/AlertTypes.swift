//
//  AlertTypes.swift
//  GitIt
//
//  Created by Loay Ashraf on 20/02/2022.
//

import UIKit

enum Alert {
    
    case locationServicesOff((() -> Void)? = nil)
    case locationAccessDenied((() -> Void)? = nil)
    case locationAccessRestricted((() -> Void)? = nil)
    case notificationAccessDenied((() -> Void)? = nil)
    case notificationAuthorizationError((() -> Void)? = nil)
    
    var controller: UIAlertController {
        switch self {
        case .locationServicesOff(let handler): return AlertConstants.TurnOnLocationServices.alertController(handler: handler)
        case .locationAccessDenied(let handler): return AlertConstants.LocationAccessDenied.alertController(handler: handler)
        case .locationAccessRestricted(let handler): return AlertConstants.LocationAccessRestricted.alertController(handler: handler)
        case .notificationAccessDenied(let handler): return AlertConstants.NotificationsAccessDenied.alertController(handler: handler)
        case .notificationAuthorizationError(let handler): return AlertConstants.NotificationsAuthorizationError.alertController(handler: handler)
        }
    }
    
}
