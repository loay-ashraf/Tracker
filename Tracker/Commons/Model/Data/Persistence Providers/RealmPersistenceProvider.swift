//
//  RealmPersistenceProvider.swift
//  GitIt
//
//  Created by Loay Ashraf on 27/02/2022.
//

import Foundation
import RealmSwift

class RealmPersistenceProvider: DataPersistenceProvider {
    
    // MARK: - Properties

    var realm: Realm { return try! Realm() }
    
    // MARK: - Write Methods

    func insert<T: Object>(_ newObject: T) throws {
        do {
            try realm.write { realm.add(newObject) }
        } catch  {
            throw RealmError.writing(error)
        }
    }

    func delete<T: Object>(_ object: T) throws {
        do {
            try realm.write { realm.delete(object) }
        } catch  {
            throw RealmError.deleting(error)
        }
    }

    func deleteAll<T: Object>(_ objectType: T.Type) throws {
        let objectsToDelete = realm.objects(objectType)
        do {
            try realm.write { realm.delete(objectsToDelete) }
        } catch  {
            throw RealmError.deleting(error)
        }
    }

    // MARK: - Read Methods

    func exists<T: Object>(_ object: T) -> Bool {
        return realm.object(ofType: T.self, forPrimaryKey: object.objectSchema.primaryKeyProperty) != nil ? true : false
    }

    func fetch<T: Object>(query: RealmQuery<T>? = nil) -> Array<T> {
        var objects: Results<T>
        if let query = query {
            objects = realm.objects(T.self).where(query)
        } else {
            objects = realm.objects(T.self)
        }
        return Array(objects)
    }

    // MARK: Clear Methods

    func clear() throws {
        do {
            try realm.write { realm.deleteAll() }
        } catch  {
            throw RealmError.deleting(error)
        }
    }
    
    // MARK: - Bind Methods
    
    func bindToCollection<T: Object>(_ listener: @escaping (RealmCollectionChange<Results<T>>) -> Void) -> NotificationToken {
        let results = realm.objects(T.self)
        return results.observe(listener)
    }
    
}
