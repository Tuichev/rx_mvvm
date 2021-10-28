//
//  UsersModel+CoreData.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 25.10.2021.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

func == (lhs: UsersModel.UserEntity, rhs: UsersModel.UserEntity) -> Bool {
    return lhs.id == rhs.id
}

extension UsersModel.UserEntity : Equatable { }

extension UsersModel.UserEntity : IdentifiableType {
    typealias Identity = String
    
    var identity: Identity { return id.description }
}

extension UsersModel.UserEntity : Persistable {
    typealias T = NSManagedObject
    
    static var entityName: String {
        return "UserEntity"
    }
    
    static var primaryAttributeName: String {
        return "id"
    }
    
    init(entity: T) {
        id = (entity.value(forKey: "id") as? Int) ?? 0
        email = entity.value(forKey: "email") as? String
        firstName = entity.value(forKey: "firstName") as? String
        lastName = entity.value(forKey: "lastName") as? String
        avatar = entity.value(forKey: "avatar") as? String
    }
    
    func update(_ entity: T) {
        entity.setValue(Int32(id), forKey: "id")
        entity.setValue(email, forKey: "email")
        entity.setValue(firstName, forKey: "firstName")
        entity.setValue(lastName, forKey: "lastName")
        entity.setValue(avatar, forKey: "avatar")
        
        do {
            try entity.managedObjectContext?.save()
        } catch let e {
            printDebug(e)
        }
    }
}

