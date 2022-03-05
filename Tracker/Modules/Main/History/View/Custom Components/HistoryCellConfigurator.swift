//
//  HistoryCellConfigurator.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import UIKit

class HistoryCellConfigurator: CollectionViewCellConfigurator {
    
    override func configure<T>(_ cell: UICollectionViewCell, forDisplaying item: T) {
        if let cell = cell as? HistoryCell, let item = item as? HistoryCellViewModel {
            cell.descriptionLabel.text = "Pending geocode"
            cell.latitudeLabel.text = item.latitude.description
            cell.longitudeLabel.text = item.longitude.description
            cell.dateLabel.text = item.date.description
            cell.setNeedsLayout()
        }
    }
    
}
