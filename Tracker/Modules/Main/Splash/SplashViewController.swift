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
        Task {
            await setup()
        }
    }
    
    // MARK: - Setup Methods
    
    @MainActor private func setup() async {
        do {
            try locationManager.setup()
            try await notificationManager.setup()
            presentTabBarController()
        } catch let error as LocationError {
            guard let alert = error.alert(handler: { self.presentTabBarController() }) else { return }
            AlertHelper.showAlert(alert: alert)
        } catch let error as NotificationError {
            guard let alert = error.alert(handler: { self.presentTabBarController() }) else { return }
            AlertHelper.showAlert(alert: alert)
        } catch { }
        setupLocationNotifications()
    }
    
    private func setupLocationNotifications() {
        locationManager.bindLocationString { [weak self] locationString in
            guard let locationString = locationString else { return }
            self?.notificationManager.sendNotification(notification: .locationUpdated(locationString))
        }
    }
    
    // MARK: - Tab Bar Presentation Method
    
    private func presentTabBarController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let storyBoard = StoryboardConstants.main
            let tabBarController = storyBoard.instantiateViewController(identifier: "tabBarVC")
            tabBarController.modalPresentationStyle = .fullScreen
            NavigationRouter.present(viewController: tabBarController)
        }
    }

}
