//
//  NotificationAccessViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 07/03/2022.
//

import UIKit
import Lottie

class NotificationAccessViewController: UIViewController {

    // MARK: - Properties
    
    weak var delegate: OnboardingNotificationAccessDelegate?
    
    let notificationManager = NotificationManager.standard
    
    // MARK: - View Outlets
    
    @IBOutlet weak var noticationsAccessAnimationView: AnimationView!
    @IBOutlet weak var grantNotificationsAccessButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        noticationsAccessAnimationView.animation = .named("notifications-access")
        noticationsAccessAnimationView.contentMode = .scaleAspectFit
        noticationsAccessAnimationView.loopMode = .loop
        noticationsAccessAnimationView.animationSpeed = 0.5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if delegate?.isNotificationUnlocked == true, grantNotificationsAccessButton.currentTitle != "Access Granted" {
            grantNotificationsAccessButton.isEnabled = true
        }
        DispatchQueue.main.async {
            self.noticationsAccessAnimationView.play()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.main.async {
            self.noticationsAccessAnimationView.stop()
        }
    }
    
    // MARK: - View Actions
    
    @IBAction func grantNotificationsAccess(_ sender: UIButton) {
        Task {
            let authorizationStatus = try? await notificationManager.requestAuthorization()
            if authorizationStatus == .authorized {
                delegate?.didFinishNotificationsAccess()
                DispatchQueue.main.async {
                    self.grantNotificationsAccessButton.isEnabled = false
                    self.grantNotificationsAccessButton.setTitle("Access Granted", for: .normal)
                }
            } else {
                DispatchQueue.main.async {
                    AlertHelper.showAlert(alert: .notificationAccessDenied({ self.delegate?.didFinishNotificationsAccess() }))
                }
            }
        }
    }
    
}
