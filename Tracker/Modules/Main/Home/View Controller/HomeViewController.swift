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
        NavigationBarConstants.configureAppearance(for: navigationController?.navigationBar)
        currentLocationView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.85)
        bindToViewModel()
    }
    
    func updateLocationMap(withLocation location: CLLocation?) {
        DispatchQueue.main.async {
            guard let location = location else {
                return
            }
            self.renderLocationOnMap(location)
        }
    }
    
    func updateLocationLabel(withLocationString locationString: String?) {
        DispatchQueue.main.async {
            guard let locationString = locationString else {
                UIView.transition(with: self.currentLocationView,
                                  duration: 0.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.currentLocationView.isHidden = true
                                    self.currentLocationLabel.text = ""
                                  },
                                  completion: nil)
                    
                return
            }
            UIView.transition(with: self.currentLocationView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.currentLocationView.isHidden = false
                                self.currentLocationLabel.text = locationString
                              },
                              completion: nil)
        }
    }
    
    func renderLocationOnMap(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: - View Actions
    
    @IBAction func openSettings(_ sender: UIBarButtonItem) {
        let settingsURL = ModelConstants.settingsURL
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        guard let latitude = viewModel.location.value?.coordinate.latitude, let longitude = viewModel.location.value?.coordinate.longitude else {
            return
        }
        if let url = URL(string: "https://maps.apple.com?ll=\(latitude),\(longitude)") {
            URLHelper.shareWebsite(url)
        }
    }
    
    // MARK: - Bind to ViewModel Method
    
    func bindToViewModel() {
        viewModel.bindViewModel(locationListener: { [weak self] location in self?.updateLocationMap(withLocation: location) },
                                locationStringListener: { [weak self] locationString in self?.updateLocationLabel(withLocationString: locationString) })
    }
    
}
