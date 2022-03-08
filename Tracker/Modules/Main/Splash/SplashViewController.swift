//
//  SplashViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 03/03/2022.
//

import UIKit
import CoreLocation
import Lottie

class SplashViewController: UIViewController {

    // MARK: - Properties
    
    let dataManager = DataManager.standard
    let locationManager = LocationManager.standard
    let notificationManager = NotificationManager.standard
    
    // MARK: - View Outlets
    
    @IBOutlet weak var activityIndicatorAnimationView: AnimationView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        activityIndicatorAnimationView.animation = .named("activity-indicator")
        activityIndicatorAnimationView.contentMode = .scaleAspectFill
        activityIndicatorAnimationView.loopMode = .loop
        activityIndicatorAnimationView.animationSpeed = 1.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.activityIndicatorAnimationView.play()
        }
        Task {
            guard dataManager.userDefaultsPersistenceProvider.userOnboardedKey else {
                presentOnboardingController()
                return
            }
            await setup()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.main.async {
            self.activityIndicatorAnimationView.stop()
        }
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToSplash(unwindSegue: UIStoryboardSegue) { }
    
    // MARK: - Setup Methods
    
    @MainActor private func setup() async {
        try? dataManager.setup()
        try? dataManager.loadData()
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
        setupLocationEntry()
    }
    
    private func setupLocationNotifications() {
        locationManager.bindLocationString { [weak self] locationString in
            guard let locationString = locationString else { return }
            self?.notificationManager.sendNotification(notification: .locationUpdated(locationString))
        }
    }
    
    private func setupLocationEntry() {
        locationManager.bindLocation { location in
            guard let location = location else { return }
            Task {
                let historyModel = await HistoryModel(from: location)
                try? HistoryManager.standard.add(entry: historyModel)
            }
        }
    }
    
    // MARK: - Controllers presentation Methods
    
    private func presentTabBarController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let storyBoard = StoryboardConstants.main
            let tabBarController = storyBoard.instantiateViewController(identifier: "tabBarVC")
            tabBarController.modalPresentationStyle = .fullScreen
            NavigationRouter.present(viewController: tabBarController)
        }
    }
    
    private func presentOnboardingController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let storyBoard = StoryboardConstants.main
            let tabBarController = storyBoard.instantiateViewController(identifier: "OnboardingVC")
            tabBarController.modalPresentationStyle = .fullScreen
            NavigationRouter.present(viewController: tabBarController)
        }
    }
    
}
