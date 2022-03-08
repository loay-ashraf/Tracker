//
//  LocationAccessViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 07/03/2022.
//

import UIKit
import Lottie

class LocationAccessViewController: UIViewController {

    // MARK: - Properties
    
    weak var delegate: OnboardingLocationAccessDelegate?
    
    let locationManager = LocationManager.standard
    
    // MARK: - View Outlets
    
    @IBOutlet weak var locaionAccessAnimationView: AnimationView!
    @IBOutlet weak var grantLocationAccessButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locaionAccessAnimationView.animation = .named("location-access")
        locaionAccessAnimationView.contentMode = .scaleAspectFit
        locaionAccessAnimationView.loopMode = .loop
        locaionAccessAnimationView.animationSpeed = 0.5
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.locaionAccessAnimationView.play()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.main.async {
            self.locaionAccessAnimationView.stop()
        }
    }
    
    // MARK: - View Actions
    
    @IBAction func grantLocationAccess(_ sender: UIButton) {
        locationManager.requestAuthorization { [weak self] authorizationStatus in
            if authorizationStatus == .authorizedAlways {
                self?.delegate?.didFinishLocationAccess()
                DispatchQueue.main.async {
                    self?.grantLocationAccessButton.isEnabled = false
                    self?.grantLocationAccessButton.setTitle("Access Granted", for: .normal)
                }
            } else {
                AlertHelper.showAlert(alert: .locationAccessDenied({ self?.delegate?.didFinishLocationAccess() }))
            }
        }
    }
    
}
