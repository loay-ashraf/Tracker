//
//  TableViewEditResponder.swift
//  Tracker
//
//  Created by Loay Ashraf on 06/03/2022.
//

import UIKit

class TableViewEditResponder {
    
    weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func respondToEdit(editingStyle: UITableViewCell.EditingStyle, atRow row: Int) { }
    
}
