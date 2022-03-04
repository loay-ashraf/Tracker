//
//  HomeLogicController.swift
//  Tracker
//
//  Created by Loay Ashraf on 03/03/2022.
//

import Foundation
import CoreLocation

class HomeLogicController {
    
    // MARK: Properties
    
    let locationManager = LocationManager.standard
    var location = Observable<CLLocation>()
    var locationString = Observable<String>()
    
    // MARK: Initialization
    
    init() {
        bindToLocation()
    }
    
    // MARK: Binding Methods
    
    func bindToLocation() {
        locationManager.bindLocation { [weak self] location in
            self?.location.value = location
        }
        locationManager.bindLocationString { [weak self] locationString in
            self?.locationString.value = locationString
        }
    }
    
    func bindModel(locationListener: @escaping (CLLocation?) -> Void, locationStringListener: @escaping (String?) -> Void) {
        location.bind(locationListener)
        locationString.bind(locationStringListener)
    }
    
}
