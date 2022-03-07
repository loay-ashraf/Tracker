//
//  HistoryDataSource.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import UIKit

class HistoryDataSource: TableViewDataSource<HistoryCellViewModel> {
    
    init(_ viewController: UIViewController) {
        super.init()
        cellClass = HistoryCell.self
        cellConfigurator = HistoryCellConfigurator()
        editResponder = HistoryEditResponder(viewController)
    }
    
}
