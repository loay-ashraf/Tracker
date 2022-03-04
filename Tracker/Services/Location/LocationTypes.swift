//
//  LocationTypes.swift
//  Tracker
//
//  Created by Loay Ashraf on 04/03/2022.
//

import Foundation

enum LocationError: Error {
    
    case locationServicesOff
    case locationAccessDenied
    case locationAccessRestricted
    
    func alert(handler: (() -> Void)? = nil) -> Alert? {
        switch self {
        case .locationServicesOff: return Alert.locationServicesOff(handler)
        case .locationAccessDenied: return Alert.locationAccessDenied(handler)
        case .locationAccessRestricted: return Alert.locationAccessRestricted(handler)
        }
    }
    
}
