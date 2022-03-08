//
//  Constants.swift
//  GitIt
//
//  Created by Loay Ashraf on 27/12/2021.
//

import Foundation
import UIKit
import NotificationBannerSwift
import Network

// MARK: - Constants Shortcuts

// Model Shortcuts
typealias ModelConstants = Constants.Model
// View Shortcuts
typealias ViewConstants = Constants.View
typealias StoryboardConstants = ViewConstants.Storyboard
typealias NavigationBarConstants = ViewConstants.NavigationBar
typealias AlertConstants = ViewConstants.Alert
typealias NotificationConstants = ViewConstants.Notification
typealias EmptyConstants = ViewConstants.Empty

struct Constants {
    
    // MARK: - Model Constants
    
    struct Model {
       
        static let settingsURL = URL(string: UIApplication.openSettingsURLString)!
        
    }
    
    // MARK: - Services Constants
    
    struct Services {
        
        
    }
    
    // MARK: - View Constants
    
    struct View {
        
        struct Storyboard {
            
            static let main = UIStoryboard(name: "Main", bundle: nil)
            
        }
        
        // MARK: - Navigation Bar Constants
        
        struct NavigationBar {
            
            static func configureAppearance(for navigationBar: UINavigationBar?) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.titleTextAttributes[.foregroundColor] = UIColor.white
                appearance.largeTitleTextAttributes[.foregroundColor] = UIColor.white
                appearance.backgroundColor = UIColor(named: "AccentColor")
                navigationBar?.standardAppearance = appearance
                navigationBar?.scrollEdgeAppearance = appearance
                navigationBar?.tintColor = .white
            }
            
        }
        
        // MARK: - Alert Constants
        
        struct Alert {
            
            struct TurnOnLocationServices {

                static let title = "Turn On Location Services".localized()
                static let message = "Location Services are turned off. to turn on, go to 'Settings > Privacy > Location Services'".localized()

                static func alertController(handler: (() -> Void)? = nil) -> UIAlertController {
                    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    controller.addAction(ViewConstants.Alert.okAction { action in handler?() })
                    return controller
                }

            }
            
            struct LocationAccessDenied {

                static let title = "Denied Location Access".localized()
                static let message = "You've denied location access. to grant access, go to 'Settings > Tracker > Location Services'.".localized()

                static func alertController(handler: (() -> Void)? = nil) -> UIAlertController {
                    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    controller.addAction(ViewConstants.Alert.okAction { action in handler?() })
                    return controller
                }

            }
            
            struct LocationAccessRestricted {

                static let title = "Restricted Location Access".localized()
                static let message = "Location access is restricted.".localized()

                static func alertController(handler: (() -> Void)? = nil) -> UIAlertController {
                    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    controller.addAction(ViewConstants.Alert.okAction { action in handler?() })
                    return controller
                }

            }
            
            struct NotificationsAccessDenied {

                static let title = "Denied Notifications Access".localized()
                static let message = "You've denied notifications access. to grant access, go to 'Settings > Tracker > Notifications'.".localized()

                static func alertController(handler: (() -> Void)? = nil) -> UIAlertController {
                    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    controller.addAction(ViewConstants.Alert.okAction { action in handler?() })
                    return controller
                }

            }
            
            struct NotificationsAuthorizationError {

                static let title = "Notifications Authorization Error".localized()
                static let message = "An error occured while requesting notifications authorization, try again later.".localized()

                static func alertController(handler: (() -> Void)? = nil) -> UIAlertController {
                    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    controller.addAction(ViewConstants.Alert.okAction { action in handler?() })
                    return controller
                }

            }
            
            struct ClearHistory {

                static let title = "Clear Location History?".localized()
                static let message = "You're about to erase your location history, this action can't be undone, proceed?".localized()
                static let clearActionTitle = "Clear".localized()

                static func alertController(primaryHandler: @escaping () -> Void, secondaryHandler: (() -> Void)? = nil) -> UIAlertController {
                    let controller = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
                    controller.addAction(UIAlertAction(title: clearActionTitle, style: .destructive, handler: { action in
                        primaryHandler()
                    }))
                    controller.addAction(ViewConstants.Alert.cancelAction { action in secondaryHandler?() })
                    return controller
                }

            }
            
            static func okAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction { return UIAlertAction(title: "Ok".localized(), style: .cancel, handler: handler) }
            static func cancelAction(handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction { return UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: handler) }
            
        }
        
        // MARK: - Notification Constants
        
        struct Notification {
            
            struct LocationUpdated {
                
                static let title = "New location entry".localized()

                static func notificationRequest(body: String) -> UNNotificationRequest {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.body = body
                    let request = UNNotificationRequest(identifier: "TrackerLocationUpdated", content: content, trigger: nil)
                    return request
                }

            }
            
            struct LocationUpdatedBanner {

                static let title = "New Location entry".localized()

                static func notificationBanner(subtitle: String) -> FloatingNotificationBanner {
                    let banner = FloatingNotificationBanner(title: title, subtitle: subtitle, style: .info)
                    banner.autoDismiss = true
                    banner.dismissOnTap = true
                    banner.dismissOnSwipeUp = true
                    return banner
                }

            }
            
        }
        
        // MARK: - Empty Constants
        
        struct Empty {
            
            // General empty image and title
            struct General {
                
                static private let image = UIImage(systemName: "exclamationmark")
                static private let title = "WoW, such empty".localized()
                static let viewModel = EmptyViewModel(image: image, title: title)
                
            }
            
            // General empty image and title
            struct History {
                
                static private let image = UIImage(named: "Empty Image")
                static private let title = "You Location history is Empty!".localized()
                static let viewModel = EmptyViewModel(image: image, title: title)
                
            }
            
        }
        
    }
    
}
