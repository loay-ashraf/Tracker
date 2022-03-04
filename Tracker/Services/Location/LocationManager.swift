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
    
    // MARK: - Initialization
    
    private override init() { super.init() }
    
    // MARK: - Setup Method
    
    func setup() throws {
        manager.delegate = self
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
        if authorizationStatus == .notDetermined {
            manager.requestAlwaysAuthorization()
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
    
    // MARK: - Geocode Reverse Method
    
    func reverseGeocode(_ location: CLLocation) async -> String {
        return await withUnsafeContinuation { continuation in
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location, preferredLocale: .current) { placemarks, error in
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
