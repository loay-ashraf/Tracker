//
//  HomeViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 02/03/2022.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = LocationManager.standard
    let notificationManager = NotificationManager.standard
    
    @IBOutlet weak var currentLocationView: UIView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.setup()
        notificationManager.setup()
        locationManager.bindLocation { [weak self] location in
            self?.updateView(withLocation: location)
        }
        locationManager.startUpdate()
    }
    
    func configureView() {
        currentLocationView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.85)
    }
    
    @MainActor func updateView(withLocation location: CLLocation?) {
        guard let location = location else {
            return
        }
        renderLocationOnMap(location)
        Task {
            let locationString = await resolveLocationGeocode(location)
            self.currentLocationLabel.text = locationString
            self.notificationManager.sendNotification(notification: .locationChanged(locationString))
        }
    }
    
}

extension HomeViewController {
    
    func renderLocationOnMap(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)

        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    func resolveLocationGeocode(_ location: CLLocation) async -> String {
        let geocoder = CLGeocoder()
        return await withUnsafeContinuation { continuation in
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
