//
//  HistoryCell.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import UIKit

class HistoryCell: TableViewCell, InterfaceBuilderTableViewCell {

    // MARK: - Properties
    
    override class var reuseIdentifier: String { return String(describing: HistoryCell.self) }
    override class var nib: UINib { return UINib(nibName: String(describing: HistoryCell.self), bundle: nil) }
    
    var tapGestureRecognizer = UITapGestureRecognizer()
    
    // MARK: - View Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureGestures()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureShadowPath()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
        latitudeLabel.text = nil
        longitudeLabel.text = nil
        dateLabel.text = nil
    }
    
    // MARK: - View Helper Methods
    
    func configureGestures() {
        // add dummy gesture recognizer to block delegate from responding to touches between cells
        let xTapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        xTapGestureRecognizer.delegate = self
        addGestureRecognizer(xTapGestureRecognizer)
        // add gesture recognizer to animate cell selection
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
        tapGestureRecognizer.delegate = self
        containerView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureShadowPath() {
        // Guard check to avoid IBDesignable agent crash
        guard let containerView = containerView else { return }
        let radius = containerView.cornerRadius
        containerView.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: radius).cgPath
        containerView.shouldRasterize = true
        containerView.rasterizationScale = UIScreen.main.scale
    }
    
    // MARK: - View Actions
    
    func containerViewTapped() {
        let originalColor = containerView.backgroundColor
        containerView.backgroundColor = .lightGray
        UIView.animate(withDuration: 0.75) {
            self.containerView.backgroundColor = originalColor
        }
    }
    
}

extension HistoryCell {
    
    // MARK: - Gesture Delegate
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == tapGestureRecognizer, touch.view?.isDescendant(of: containerView) == true, !isEditing {
            containerViewTapped()
            return false
        } else if touch.view?.isDescendant(of: containerView) == true || isEditing {
            return false
        }
        return true
    }
    
}
