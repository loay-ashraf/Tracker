//
//  LocationHistory.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import Foundation
import RealmSwift
import CoreLocation

class Location: Object {
    
    // MARK: - Properties
    
    @Persisted var xDescription: String
    @Persisted var latitude: CLLocationDegrees
    @Persisted var longitude: CLLocationDegrees
    @Persisted var date: Date
    
    var location: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    // MARK: - Initialization
    
    convenience init(form location: CLLocation) {
        self.init()
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
    
    convenience init(form historyModel: HistoryModel) {
        self.init()
        self.xDescription = historyModel.description
        self.latitude = historyModel.latitude
        self.longitude = historyModel.longitude
        self.date = historyModel.date
    }
    
}

