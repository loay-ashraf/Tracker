//
//  HistoryDetailViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 06/03/2022.
//

import UIKit
import MapKit

class HistoryDetailViewController: UIViewController, StoryboardableViewController {
    
    // MARK: - Properties
    
    static let storyboardIdentifier = "HistoryDetailVC"
    
    var location: CLLocation
    var locationDescription: String
    var locationCoordinate: CLLocationCoordinate2D
    var locationDate: Date
    
    // MARK: - View Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationLatitudeLabel: UILabel!
    @IBOutlet weak var locationLongitudeLabel: UILabel!
    @IBOutlet weak var locationDateLabel: UILabel!
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder, cellViewModel: HistoryCellViewModel) {
        location = CLLocation(latitude: cellViewModel.latitude, longitude: cellViewModel.longitude)
        locationDescription = cellViewModel.description
        locationCoordinate = location.coordinate
        locationDate = cellViewModel.date
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Fatal Error, this view controller shouldn't be instantiated via storyboard segue.")
    }
    
    static func instatiate<T: CellViewModel>(cellViewModel: T) -> UIViewController {
        if let cellViewModel = cellViewModel as? HistoryCellViewModel {
            let storyBoard = StoryboardConstants.main
            return storyBoard.instantiateViewController(identifier: self.storyboardIdentifier, creator: { coder -> HistoryDetailViewController in
                            self.init(coder: coder, cellViewModel: cellViewModel)!
                    })
        } else {
            return UIViewController()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        updateLocationMap()
        updateLocationLabels()
        
    }
    
    // MARK: - View Helper Methods
    
    func configureView() {
        locationView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.85)
    }
    
    func updateLocationMap() {
        DispatchQueue.main.async {
            self.renderLocationOnMap(self.location)
        }
    }
    
    func updateLocationLabels() {
        DispatchQueue.main.async {
            UIView.transition(with: self.locationView,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.locationView.isHidden = false
                                self.locationLabel.text = self.locationDescription
                                self.locationLatitudeLabel.text = self.locationCoordinate.latitude.description
                                self.locationLongitudeLabel.text = self.locationCoordinate.longitude.description
                                self.locationDateLabel.text = self.locationDate.description
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

        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
    
    // MARK: - View Actions
    
    @IBAction func share(_ sender: UIBarButtonItem) {
        if let url = URL(string: "https://maps.apple.com?ll=\(locationCoordinate.latitude),\(locationCoordinate.longitude)") {
            URLHelper.shareWebsite(url)
        }
    }
    
}
