//
//  LocationManager.swift
//  Tracker
//
//  Created by Loay Ashraf on 02/03/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let standard = LocationManager()
    
    private let manager = CLLocationManager()
    private var servicesEnabled: Bool { return CLLocationManager.locationServicesEnabled() }
    private var authorizationStatus: CLAuthorizationStatus { return CLLocationManager.authorizationStatus() }
    private var currentLocation = Observable<CLLocation>()
    
    private override init() { super.init() }
    
    func setup() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        guard servicesEnabled == true else {
            AlertHelper.showAlert(alert: .locationServicesOff)
            return
        }
        guard authorizationStatus != .denied else {
            AlertHelper.showAlert(alert: .locationPermissionsDenied)
            return
        }
        guard authorizationStatus != .restricted else {
            AlertHelper.showAlert(alert: .locationPermissionsRestricted)
            return
        }
        if authorizationStatus == .notDetermined {
            manager.requestAlwaysAuthorization()
        }
    }
    
    func startUpdate() {
        manager.startUpdatingLocation()
    }
    
    func stopUpdate() {
        manager.stopUpdatingLocation()
    }
    
    func startBackgroundMonitoring() {
        manager.startMonitoringSignificantLocationChanges()
        manager.startMonitoringVisits()
    }
    
    func stopBackgroundMonitoring() {
        manager.stopMonitoringSignificantLocationChanges()
        manager.stopMonitoringVisits()
    }
    
    func bindLocation(_ listener: @escaping ((CLLocation?) -> Void)) {
        currentLocation.bind(listener)
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation.value = location
        }
    }
    
}
