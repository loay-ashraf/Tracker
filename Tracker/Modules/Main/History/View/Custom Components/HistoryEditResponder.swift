//
//  HistoryEditResponder.swift
//  Tracker
//
//  Created by Loay Ashraf on 06/03/2022.
//

import UIKit

class HistoryEditResponder: TableViewEditResponder {
    
    override func respondToEdit(editingStyle: UITableViewCell.EditingStyle, atRow row: Int) {
        if let viewController = viewController as? HistoryViewController, editingStyle == .delete {
            viewController.deleteEntry(atRow: row)
        }
    }
    
}
