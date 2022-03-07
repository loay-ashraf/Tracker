//
//  HistoryViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import UIKit

class HistoryViewController: DPSFDynamicTableViewController<HistoryViewModel> {

    // MARK: - Properties
    
    let notificationManager = NotificationManager.standard
    
    // MARK: - View Outlets
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tableViewDataSource = HistoryDataSource(self)
        tableViewDelegate = HistoryDelegate(self)
        viewModel = HistoryViewModel()
        emptyViewModel = EmptyConstants.History.viewModel
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        notificationManager.resetNotificationBadge()
    }
    
    // MARK: - View Helper Methods
    
    override func configureView() {
        super.configureView()
        NavigationBarConstants.configureAppearance(for: navigationController?.navigationBar)
        xTableView.contentInset = .init(top: 20, left: 0, bottom: 20, right: 0)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            editButton?.title = "Done"
        } else {
            editButton?.title = "Edit"
        }
    }
    
    // MARK: - View Actions
    
    @IBAction func edit(_ sender: UIBarButtonItem) {
        setEditing(!xTableView.isEditing, animated: true)
    }
    
    @IBAction func clear(_ sender: UIBarButtonItem) {
        AlertHelper.showAlert(alert: .clearHistory({ [weak self] in self?.viewModel.clear() }))
    }
    
    func showDetail(atRow row: Int) {
        let cellViewModelItem = viewModel.cellViewModelArray[row]
        let detailVC = HistoryDetailViewController.instatiate(cellViewModel: cellViewModelItem)
        NavigationRouter.push(viewController: detailVC)
    }
    
    func deleteEntry(atRow row: Int) {
        viewModel.delete(atRow: row)
    }
    
    // MARK: - Bind to View Model Method
    
    func bindToViewModel() {
        viewModel.bind { [weak self] locations in
            if let locations = locations {
                self?.tableViewDataSource.cellViewModels = locations
                DispatchQueue.main.async {
                    if locations.isEmpty {
                        self?.xTableView.transition(to: .empty(self!.emptyViewModel))
                        self?.editButton.isEnabled = false
                        self?.clearButton.isEnabled = false
                    } else {
                        self?.xTableView.transition(to: .presenting)
                        self?.editButton.isEnabled = true
                        self?.clearButton.isEnabled = true
                    }
                }
            }
        }
    }

}
