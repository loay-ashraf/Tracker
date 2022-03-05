//
//  HistoryCell.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import UIKit

class HistoryCell: CollectionViewCell, InterfaceBuilderCollectionViewCell {

    // MARK: - Properties
    
    override class var reuseIdentifier: String { return String(describing: HistoryCell.self) }
    override class var nib: UINib { return UINib(nibName: String(describing: HistoryCell.self), bundle: nil) }
    
    // MARK: - View Outlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - View Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
        latitudeLabel.text = nil
        longitudeLabel.text = nil
        dateLabel.text = nil
    }

}
