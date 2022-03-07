//
//  HistoryModel.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import Foundation
import CoreLocation

struct HistoryModel: Model {

    // MARK: - Properties
    
    typealias CollectionCellViewModelType = HistoryCellViewModel
    
    var description: String
    var latitude: Double
    var longitude: Double
    var date: Date
    
    // MARK: - Initialization
    
    init() {
        description = ""
        latitude = 0.0
        longitude = 0.0
        date = Date()
    }
    
    init(from collectionCellViewModel: HistoryCellViewModel) {
        description = collectionCellViewModel.description
        latitude = collectionCellViewModel.latitude
        longitude = collectionCellViewModel.longitude
        date = collectionCellViewModel.date
    }
    
    init(from location: Location) {
        description = location.xDescription
        latitude = location.latitude
        longitude = location.longitude
        date = location.date
    }
    
    init(from location: CLLocation) async {
        description = await LocationManager.standard.reverseGeocode(location)
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
        date = location.timestamp
    }
    
}
