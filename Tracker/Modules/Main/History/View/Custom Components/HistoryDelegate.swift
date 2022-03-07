//
//  HistoryDelegate.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import UIKit

class HistoryDelegate: TableViewDelegate {
    
    init(_ viewController: UIViewController) {
        super.init()
        tapResponder = HistoryTapResponder(viewController)
    }
    
}
