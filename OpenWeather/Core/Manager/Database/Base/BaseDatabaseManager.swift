//
//  BaseDatabaseManager.swift
//  OpenWeather
//
//  Created by Kate Nedelko on 18.06.23.
//

import RealmSwift

open class BaseDatabaseManager<Model: Object> {
    
    // - Realm
    private(set) var realm = try! Realm()
    
    var items: Results<Model> {
        return realm.objects(Model.self)
    }
    
    func getItemById(id: String) -> Model? {
        return realm.object(ofType: Model.self, forPrimaryKey: id)
    }
    
    func rewrite(_ array: [Model]) {
        try? self.realm.write { [weak self] in
            guard let self else { return }
            let oldItems = items.filter { r in !array.contains(where: { self.areTheSameItems($0, r) == true })}
            self.realm.delete(oldItems)
            self.realm.add(array, update: .all)
        }
    }
    
    func save(_ array: [Model]) {
        try? self.realm.write { [weak self] in
            self?.realm.add(array, update: .all)
        }
    }

    func save(_ model: Model) {
        try? self.realm.write { [weak self] in
            self?.realm.add(model, update: .modified)
        }
    }
    
    func clear() {
        try! realm.write {
            realm.delete(items)
        }
    }
    
    func delete(_ model: Model) {
        try! realm.write {
            realm.delete(model)
        }
    }
    
    func areTheSameItems(_ first: Model, _ second: Model) -> Bool {
        preconditionFailure("areTheSameItems method must be overridden")
    }
    
}
