//
//  HistoryTapResponder.swift
//  Tracker
//
//  Created by Loay Ashraf on 06/03/2022.
//

import UIKit

class HistoryTapResponder: TableViewTapResponder {
    
    override func respondToTap(atRow row: Int) {
        if let viewController = viewController as? HistoryViewController {
            viewController.showDetail(atRow: row)
        }
    }
    
}
