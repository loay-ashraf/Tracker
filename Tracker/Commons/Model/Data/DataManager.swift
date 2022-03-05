//
//  DataManager.swift
//  GitIt
//
//  Created by Loay Ashraf on 03/11/2021.
//

import Foundation

class DataManager {
    
    // MARK: - Properties
    
    static let standard = DataManager()
    var isSetup: Bool = false
    
    // MARK: - Persistence Providers
    
    let bundlePersistenceProvider = BundlePersistenceProvider()
    let realmDataPersistenceProvider = RealmPersistenceProvider()
    let fileManagerPersistenceProvider = FileManagerPersistenceProvider()
    let userDefaultsPersistenceProvider = UserDefaultsPersistenceProvider()
    
    // MARK: Initialization
    
    private init() {}
    
    // MARK: Setup Methods
    
    func setup(completionHandler: @escaping ((DataError?) -> Void)) {
        isSetup = true
        userDefaultsPersistenceProvider.setup()
    }
    
    // MARK: - Save and Load Methods
    
    func saveData() throws { }
    
    func loadData() throws {
        do {
            try HistoryManager.standard.load()
        } catch {
            if let error = error as? RealmError {
                throw DataError.realm(error)
            }
        }
    }
    
    // MARK: - Clear Methods
    
    // Clears stored data without removing UserDefaults keys
    @MainActor func clearData() throws {
//        isSetup = false
//        do {
//            // Clear data stored in Memory
//            try BookmarksManager.standard.clearAll()
//            SearchHistoryManager.standard.clearAll()
//
//            // Clear data stored in Storage
//            try realmDataPersistenceProvider.clear()
//            fileManagerPersistenceProvider.clear()
//        } catch let error as RealmError {
//            throw DataError.realm(error)
//        }
    }
    
    // Clears all stored data including UserDefaults keys
    @MainActor func clearAllData() throws {
//        isSetup = false
//        do {
//            // Clear data stored in Memory
//            try BookmarksManager.standard.clearAll()
//            SearchHistoryManager.standard.clearAll()
//
//            // Clear data stored in Storage
//            try realmDataPersistenceProvider.clear()
//            fileManagerPersistenceProvider.clear()
//            userDefaultsPersistenceProvider.clear()
//        } catch let error as RealmError {
//            throw DataError.realm(error)
//        }
    }
    
}
