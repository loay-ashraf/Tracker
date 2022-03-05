//
//  HistoryDataSource.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import UIKit

class HistoryDataSource: CollectionViewDataSource<HistoryCellViewModel> {
    
    override init() {
        super.init()
        cellClass = HistoryCell.self
        cellConfigurator = HistoryCellConfigurator()
    }
    
}
