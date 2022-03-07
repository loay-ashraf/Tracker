//
//  ConclusionViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 07/03/2022.
//

import UIKit
import Lottie

class ConclusionViewController: UIViewController {

    // MARK: - Properties
    
    let userDefaultsProvider = DataManager.standard.userDefaultsPersistenceProvider
    
    weak var delegate: OnboardingConclusionDelegate?
    
    // MARK: - View Outlets
    
    @IBOutlet weak var conclusionAnimationView: AnimationView!
    @IBOutlet weak var conclusionButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        conclusionAnimationView.contentMode = .scaleAspectFit
        conclusionAnimationView.loopMode = .loop
        conclusionAnimationView.animationSpeed = 0.5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if delegate?.isConclusionUnlocked == true {
            conclusionButton.isEnabled = true
        }
        DispatchQueue.main.async {
            self.conclusionAnimationView.play()
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DispatchQueue.main.async {
            self.conclusionAnimationView.stop()
        }
    }
    
    // MARK: - View Actions
    
    @IBAction func takeMeHome(_ sender: UIButton) {
        userDefaultsProvider.userOnboardedKey = true
    }
    
}
