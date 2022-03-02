//
//  AlertTypes.swift
//  GitIt
//
//  Created by Loay Ashraf on 20/02/2022.
//

import UIKit

enum Alert {
    
    case locationServicesOff
    case locationPermissionsDenied
    case locationPermissionsRestricted
    
    var controller: UIAlertController {
        switch self {
        case .locationServicesOff: return AlertConstants.TurnOnLocationServices.alertController()
        case .locationPermissionsDenied: return AlertConstants.LocationAccessDenied.alertController()
        case .locationPermissionsRestricted: return AlertConstants.LocationAccessRestricted.alertController()
        }
    }
    
}

enum Notification {
    
    case locationChanged(String)
    
    var request: UNNotificationRequest {
        switch self {
        case .locationChanged(let body): return NotificationConstants.LocationChanged.notificationRequest(body: body)
        }
    }
    
}

