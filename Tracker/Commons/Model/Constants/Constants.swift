//
//  Constants.swift
//  GitIt
//
//  Created by Loay Ashraf on 27/12/2021.
//

import Foundation
import UIKit
import Network

// MARK: - Constants Shortcuts

// Model Shortcuts
typealias ModelConstants = Constants.Model
// View Shortcuts
typealias ViewConstants = Constants.View
typealias StoryboardConstants = ViewConstants.Storyboard
typealias NavigayionBarConstants = ViewConstants.NavigationBar
typealias AlertConstants = ViewConstants.Alert
typealias NotificationConstants = ViewConstants.Notification
typealias ErrorConstants = ViewConstants.Error
typealias EmptyConstants = ViewConstants.Empty

struct Constants {
    
    // MARK: - Model Constants
    
    struct Model {
       
        
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

                static func alertController() -> UIAlertController {
                    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    controller.addAction(ViewConstants.Alert.okAction)
                    return controller
                }

            }
            
            struct LocationAccessDenied {

                static let title = "Denied Location Access".localized()
                static let message = "You've denied location access. to grant access, go to 'Settings > Privacy > Location Services > Tracker'".localized()

                static func alertController() -> UIAlertController {
                    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    controller.addAction(ViewConstants.Alert.okAction)
                    return controller
                }

            }
            
            struct LocationAccessRestricted {

                static let title = "Restricted Location Access".localized()
                static let message = "Location access is restricted.".localized()

                static func alertController() -> UIAlertController {
                    let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    controller.addAction(ViewConstants.Alert.okAction)
                    return controller
                }

            }
            
            static let okAction = UIAlertAction(title: "Ok".localized(), style: .cancel, handler: nil)
            static let cancelAction = UIAlertAction(title: "Cancel".localized(), style: .cancel, handler: nil)
            
        }
        
        // MARK: - Notification Constants
        
        struct Notification {
            
            struct LocationChanged {
                
                static let title = "Tracker".localized()
                static let subtitle = "New location entry".localized()

                static func notificationRequest(body: String) -> UNNotificationRequest {
                    let content = UNMutableNotificationContent()
                    content.title = title
                    content.subtitle = subtitle
                    content.body = body
                    let request = UNNotificationRequest(identifier: "TrackerLocationChanged", content: content, trigger: nil)
                    return request
                }

            }
            
        }
        
        // MARK: - Error Constants
        
        struct Error {
            
            // Data error image, title and message
            struct Data {
                
                static private let image = UIImage(systemName: "externaldrive.badge.xmark")
                static private let title = "Couldn't Retrieve Data".localized()
                static private let message = "We're working on it,\nWe will be back soon.".localized()
                static let viewModel = ErrorViewModel(image: image, title: title, message: message)
                
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
            
        }
        
    }
    
}
