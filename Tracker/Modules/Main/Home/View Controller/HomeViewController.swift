//
//  HomeViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 02/03/2022.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - Properties
    
    let viewModel = HomeViewModel()
    
    // MARK: - View Outlets
    
    @IBOutlet weak var currentLocationView: UIView!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - View Helper Methods
    
    func configureView() {
        currentLocationView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.85)
        bindToViewModel()
    }
    
    func updateMapView(withLocation location: CLLocation?) {
        guard let location = location else {
            return
        }
        DispatchQueue.main.async {
            self.renderLocationOnMap(location)
        }
    }
    
    func updateLocationLabel(withLocationString locationString: String?) {
        guard let locationString = locationString else {
            return
        }
        DispatchQueue.main.async {
            self.currentLocationLabel.text = locationString
        }
    }
    
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

    // MARK: - Bind to ViewModel Method
    
    func bindToViewModel() {
        viewModel.bindViewModel(locationListener: { [weak self] location in self?.updateMapView(withLocation: location) },
                                locationStringListener: { [weak self] locationString in self?.updateLocationLabel(withLocationString: locationString) })
    }
    
}
