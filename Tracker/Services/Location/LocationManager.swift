//
//  LocationManager.swift
//  Tracker
//
//  Created by Loay Ashraf on 02/03/2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    // MARK: - Properties
    
    static let standard = LocationManager()
    
    private let manager = CLLocationManager()
    private var servicesEnabled: Bool { return CLLocationManager.locationServicesEnabled() }
    private var authorizationStatus: CLAuthorizationStatus { return CLLocationManager.authorizationStatus() }
    private var currentLocation = Observable<CLLocation>()
    private var currentLocationString = Observable<String>()
    private var authorizationCallback: ((CLAuthorizationStatus) -> Void)?
    
    // MARK: - Initialization
    
    private override init() { super.init() }
    
    // MARK: - Setup Method
    
    func setup() throws {
        if manager.delegate == nil { manager.delegate = self }
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = true
        manager.startUpdatingLocation()
        guard servicesEnabled == true else {
            throw LocationError.locationServicesOff
        }
        guard authorizationStatus != .denied else {
            throw LocationError.locationAccessDenied
        }
        guard authorizationStatus != .restricted else {
            throw LocationError.locationAccessRestricted
        }
    }
    
    func requestAuthorization(then callback: @escaping (CLAuthorizationStatus) -> Void) {
        if manager.delegate == nil { manager.delegate = self }
        authorizationCallback = callback
        if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    // MARK: - Binding Methods
    
    func bindLocation(_ listener: @escaping ((CLLocation?) -> Void)) {
        currentLocation.bind(listener)
    }
    
    func bindLocationString(_ listener: @escaping ((String?) -> Void)) {
        currentLocationString.bind(listener)
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    // MARK: - Location Manager Delegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation.value = location
            Task {
                currentLocationString.value = await reverseGeocode(location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestAlwaysAuthorization()
        } else {
            authorizationCallback?(status)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if authorizationStatus == .authorizedWhenInUse {
            manager.requestAlwaysAuthorization()
        } else {
            authorizationCallback?(authorizationStatus)
        }
    }
    
    // MARK: - Geocode Reverse Method
    
    func reverseGeocode(_ location: CLLocation) async -> String {
        return await withUnsafeContinuation { continuation in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                var locationString = String()
                guard let place = placemarks?.first, error == nil else {
                    return
                }
                if let locality = place.locality {
                    locationString.append(contentsOf: locality)
                }
                if let adminRegion = place.administrativeArea {
                    locationString.append(contentsOf: ", \(adminRegion)")
                }
                continuation.resume(returning: locationString)
            }
        }
    }
    
}
