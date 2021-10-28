//
//  CoreDataManager.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 25.10.2021.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var applicationDocumentsDirectory: URL = {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            return url
        }
        
        fatalError("Unresolved error: FileManager url error in CoreDataManager")
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        if let modelURL = Bundle.main.url(forResource: "CoreDataUserModel", withExtension: "momd"),
           let result = NSManagedObjectModel(contentsOf: modelURL) {
            return result
        }
        
        fatalError("Unresolved error: didn't find CoreDataUserModel")
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("RxCoreData.sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        } catch {
            let wrappedError = CustomError.runtimeError("There was an error creating or loading the application's saved data.")
            fatalError("Unresolved error \(wrappedError)")
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}
