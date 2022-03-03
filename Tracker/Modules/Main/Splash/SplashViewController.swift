//
//  SplashViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 03/03/2022.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: - Properties
    
    let locationManager = LocationManager.standard
    let notificationManager = NotificationManager.standard
    
    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.setup()
        notificationManager.setup()
        locationManager.bindLocationString { [weak self] locationString in
            guard let locationString = locationString else {
                return
            }
            self?.notificationManager.sendNotification(notification: .locationChanged(locationString))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            //self.presentTabBarController()
        }
    }
    
    // MARK: - Tab Bar Presentation Method
    
    private func presentTabBarController() {
        let storyBoard = StoryboardConstants.main
        let tabBarController = storyBoard.instantiateViewController(identifier: "tabBarVC")
        tabBarController.modalPresentationStyle = .fullScreen
        NavigationRouter.present(viewController: tabBarController)
    }

}
