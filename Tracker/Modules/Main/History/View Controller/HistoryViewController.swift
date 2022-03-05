//
//  HistoryViewController.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import UIKit

class HistoryViewController: DPSFDynamicCollectionViewController<HistoryViewModel> {

    // MARK: - Properties
    
    var isEmpty = Observable<Bool>()
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        collectionViewDataSource = HistoryDataSource()
        collectionViewDelegate = HistoryDelegate(self)
        viewModel = HistoryViewModel()
        //emptyViewModel = EmptyConstants.Bookmarks.viewModel
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
    }
    
    // MARK: - View Actions
    
    func clear() {
        viewModel.clear()
    }
    
    func showDetail(atRow row: Int) {
//        let cellViewModelItem = viewModel.cellViewModelArray[row]
//        let detailVC = UserDetailViewController.instatiate(tableCellViewModel: cellViewModelItem)
//        NavigationRouter.push(viewController: detailVC)
    }
    
    // MARK: - Bind to View Model Method
    
    func bindToViewModel() {
        viewModel.bind { [weak self] locations in
            if let locations = locations {
                self?.collectionViewDataSource.cellViewModels = locations
                DispatchQueue.main.async {
                    if locations.isEmpty {
                        self?.xCollectionView.transition(to: .empty(self!.emptyViewModel))
                    } else {
                        self?.xCollectionView.transition(to: .presenting)
                    }
                }
                self?.isEmpty.value = self?.viewModel.isEmpty
            }
        }
    }

}
