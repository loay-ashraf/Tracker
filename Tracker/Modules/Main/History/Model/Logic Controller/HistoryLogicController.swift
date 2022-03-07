//
//  HistoryLogicController.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import Foundation
import CoreLocation

final class HistoryLogicController: DataPersistenceLogicController {
    
    // MARK: - Properties
    
    typealias DataPersistenceManagerType = HistoryManager
    typealias ModelType = HistoryModel
    
    var dataPersistenceManager =  HistoryManager.standard
    var model = Observable<Array<HistoryModel>>()
    
    // MARK: - Initialization
    
    init() {
        bindToPersistedData()
    }
    
    // MARK: - Model Manipulation Methods
    
    func add(model: HistoryModel) {
        Task {
            await MainActor.run { try? dataPersistenceManager.add(entry: model) }
        }
    }
    
    func delete(model: HistoryModel) {
        Task {
            await MainActor.run { try? dataPersistenceManager.delete(entry: model) }
        }
    }
    
    func clear() {
        Task {
            await MainActor.run { try? dataPersistenceManager.clear() }
        }
    }
    
    // MARK: - Bind to Persisted Data Method
    
    func bindToPersistedData() {
        dataPersistenceManager.bindLocations { [weak self] locationsArray in
            if let locationsArray = locationsArray {
                self?.modelArray = locationsArray.map { return HistoryModel(from: $0) }
            }
        }
    }
    
}
