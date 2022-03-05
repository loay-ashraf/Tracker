//
//  HistoryViewModel.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import Foundation

final class HistoryViewModel: DataPersistenceCollectionViewModel {

    // MARK: - Properties
    
    typealias CollectionCellViewModelType = HistoryCellViewModel
    typealias LogicControllerType = HistoryLogicController
    typealias ModelType = HistoryModel
    
    var logicController = HistoryLogicController()
    var cellViewModels = Observable<Array<HistoryCellViewModel>>()
    
    var count: Int { return cellViewModelArray.count }
    var isEmpty: Bool { return cellViewModelArray.isEmpty }
    
    // MARK: - Initialization
    
    init() {
        bindToModel()
    }
    
    // MARK: - View Actions
    
    func delete(atRow row: Int) {
        let cellViewModel = cellViewModelArray[row]
        delete(cellViewModel: cellViewModel)
    }
    
    // MARK: - View Model Manipulationn Methods
    
    func add(cellViewModel: HistoryCellViewModel) {
        return
    }
    
    func delete(cellViewModel: HistoryCellViewModel) {
        let model = HistoryModel(from: cellViewModel)
        logicController.delete(model: model)
    }
    
    func clear() {
        logicController.clear()
    }

    // MARK: - Bind to Model Method
    
    func bindToModel() {
        logicController.bind { [weak self] locationsArray in
            if let locationsArray = locationsArray {
                self?.cellViewModelArray = locationsArray.map { return HistoryCellViewModel(from: $0) }
            }
        }
    }
    
}

final class HistoryCellViewModel: CellViewModel {
    
    // MARK: - Properties
    
    typealias ModelType = HistoryModel
    
    var model: HistoryModel
    var description: String
    var latitude: Double
    var longitude: Double
    var date: Date
    
    // MARK: - Initialization
    
    init(from model: HistoryModel) {
        self.model = model
        description = model.description
        latitude = model.latitude
        longitude = model.longitude
        date = model.date
    }
    
    // MARK: - Equatable
    
    static func == (lhs: HistoryCellViewModel, rhs: HistoryCellViewModel) -> Bool {
        if lhs.model == rhs.model, lhs.description == rhs.description, lhs.latitude == rhs.longitude, lhs.date == rhs.date {
            return true
        }
        return false
    }
    
    // MARK: - Hashable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(description)
        hasher.combine(latitude)
        hasher.combine(longitude)
        hasher.combine(date)
    }
    
}
