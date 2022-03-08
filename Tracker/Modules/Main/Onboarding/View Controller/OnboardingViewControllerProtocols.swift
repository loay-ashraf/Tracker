//
//  OnboardingViewControllerProtocols.swift
//  Tracker
//
//  Created by Loay Ashraf on 08/03/2022.
//

import Foundation

protocol OnboardingLocationAccessDelegate: AnyObject {
    
    func didFinishLocationAccess()
    
}

protocol OnboardingNotificationAccessDelegate: AnyObject {
    
    var isNotificationUnlocked: Bool { get set }
    
    func didFinishNotificationsAccess()
    
}

protocol OnboardingConclusionDelegate: AnyObject {
    
    var isConclusionUnlocked: Bool { get set }
    
}
