//
//  HistoryCellConfigurator.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import UIKit

class HistoryCellConfigurator: TableViewCellConfigurator {
    
    override func configure<T>(_ cell: UITableViewCell, forDisplaying item: T) {
        if let cell = cell as? HistoryCell, let item = item as? HistoryCellViewModel {
            cell.descriptionLabel.text = item.description
            cell.latitudeLabel.text = item.latitude.description
            cell.longitudeLabel.text = item.longitude.description
            cell.dateLabel.text = item.date.description
            cell.setNeedsLayout()
        }
    }
    
}
