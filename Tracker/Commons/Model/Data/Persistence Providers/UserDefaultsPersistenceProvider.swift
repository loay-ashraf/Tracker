//
//  UserDefaultsPersistenceProvider.swift
//  GitIt
//
//  Created by Loay Ashraf on 14/01/2022.
//

import Foundation

class UserDefaultsPersistenceProvider: DataPersistenceProvider {
    
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Setup Methods
    
    func setup() {
        register(defaults: ["user-onboarded":false])
    }
    
    // MARK: - Defaults Registeration Methods
    
    func register(defaults: [String:Any]) {
        userDefaults.register(defaults: defaults)
    }
    
    // MARK: - Writing and Reading Methods
    
    func setValue(value: Any, for key: String) {
        userDefaults.set(value, forKey: key)
    }
        
    func getValue(for key: String) -> Result<Any,UserDefaultsError> {
        if let value = userDefaults.object(forKey: key) {
            return .success(value)
        }
        return .failure(.propertyNotFound)
    }
    
    // MARK: - Value Observer Methods
        
    func addValueObserver(observer: NSObject, for key: String, options: NSKeyValueObservingOptions) {
        userDefaults.addObserver(observer, forKeyPath: key, options: options, context: nil)
    }
        
    func removeValueObserver(observer: NSObject, for key: String) {
        userDefaults.removeObserver(observer, forKeyPath: key)
    }
    
    // MARK: - Clear Methods
    
    func clear() {
        userDefaults.removeObject(forKey: "user-onboarded")
    }
    
}

extension UserDefaultsPersistenceProvider {
    
    var userOnboardedKey: Bool {
        get {
            return userDefaults.bool(forKey: "user-onboarded")
        }
        set(userOnboarded) {
            userDefaults.set(userOnboarded, forKey: "user-onboarded")
        }
    }
    
}
