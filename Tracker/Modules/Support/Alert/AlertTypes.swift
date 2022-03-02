//
//  AlertTypes.swift
//  GitIt
//
//  Created by Loay Ashraf on 20/02/2022.
//

import UIKit
//import NotificationBannerSwift

enum Alert {
    
    case noInternet
    case internetError
    case networkError
    case dataError
    case signInError
    case guestSignIn(() -> Void)
    case clearSearchHistory(() -> Void)
    case clearBookmarks(() -> Void)
    case clearData
    case signOut(() -> Void)
    
    var controller: UIAlertController {
        switch self {
        default: return UIAlertController()
        }
    }
    
//    var statusBarBanner: StatusBarNotificationBanner {
//        switch self {
//        case .noInternet: return AlertConstants.NoInternet.notificationBanner()
//        default: return StatusBarNotificationBanner(title: "")
//        }
//    }
    
}
