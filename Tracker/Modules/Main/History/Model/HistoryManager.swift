//
//  HistoryManager.swift
//  Tracker
//
//  Created by Loay Ashraf on 05/03/2022.
//

import Foundation
import RealmSwift
import CoreLocation

class HistoryManager: DataPersistenceManager {
    
    // MARK: - Properties

    typealias DataPersistenceProviderType = RealmPersistenceProvider

    static let standard = HistoryManager()
    let dataPersistenceProvider = DataManager.standard.realmDataPersistenceProvider
    var notificationToken: NotificationToken?

    private var locations = Observable<Array<Location>>()
    
    // MARK: - Initialization

    private init() {
        notificationToken = dataPersistenceProvider.bindToCollection { [weak self] (changes: RealmCollectionChange<Results<Location>>) in
            switch changes {
            case .update: self?.locations.value = self?.dataPersistenceProvider.fetch()
            default: break
            }
        }
    }

    // MARK: - Save and Load Methods

    func save() throws { }

    func load() throws {
        locations.value = dataPersistenceProvider.fetch()
    }

    // MARK: - Write Methods

    @MainActor func add(entry: HistoryModel) throws {
        let locationToAdd = Location(form: entry)
        guard locationToAdd.xDescription != locations.value?.last?.xDescription else { return }
        try dataPersistenceProvider.insert(locationToAdd)
    }

    @MainActor func delete(entry: HistoryModel) throws {
        guard let locationToDelete = locations.value?.filter({ return $0.xDescription == entry.description &&
                                                                      $0.date == entry.date &&
                                                                      $0.latitude == entry.latitude &&
                                                                      $0.longitude == entry.longitude
        }).first else {
            return
        }
        try dataPersistenceProvider.delete(locationToDelete)
    }
    
    @MainActor func delete(atIndex index: Int) throws {
        guard let locationToDelete = locations.value?[index] else {
            return
        }
        try dataPersistenceProvider.delete(locationToDelete)
    }

    @MainActor func clear() throws {
        try dataPersistenceProvider.deleteAll(Location.self)
    }

    // MARK: - Bind Methods

    func bindLocations(_ listener: @escaping (Array<Location>?) -> Void) {
        locations.bind(listener)
    }
    
}
