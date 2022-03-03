//
//  HomeViewModel.swift
//  Tracker
//
//  Created by Loay Ashraf on 03/03/2022.
//

import Foundation
import CoreLocation

class HomeViewModel {
    
    // MARK: Properties
    
    let logicController = HomeLogicController()
    var location = Observable<CLLocation>()
    var locationString = Observable<String>()
    
    // MARK: Initialization
    
    init() {
        bindToModel()
    }
    
    // MARK: Binding Methods
    
    func bindToModel() {
        logicController.bindModel(locationListener: { [weak self] location in self?.location.value = location },
                                  locationStringListener: { [weak self] locationString in self?.locationString.value = locationString })
    }
    
    func bindViewModel(locationListener: @escaping (CLLocation?) -> Void, locationStringListener: @escaping (String?) -> Void) {
        location.bind(locationListener)
        locationString.bind(locationStringListener)
    }
    
}
