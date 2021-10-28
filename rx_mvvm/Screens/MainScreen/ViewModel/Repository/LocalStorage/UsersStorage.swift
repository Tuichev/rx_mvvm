//
//  UsersStorage.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation
import CoreData
import RxSwift
import RxDataSources
import RxCoreData

protocol UsersLocalStorageProtocol: AnyObject {
    func saveDataFromApi(items: [UsersModel.UserEntity])
    func fetchDataFromStorage(items: PublishSubject<[UsersModel.UserEntity]>)
}

class UsersLocalStorage: UsersLocalStorageProtocol {
    private let disposeBag = DisposeBag()
    
    private var managedObjectContext: NSManagedObjectContext! {
        return CoreDataManager.shared.managedObjectContext
    }
    
    func saveDataFromApi(items: [UsersModel.UserEntity]) {
        items.forEach({
            try? self.managedObjectContext.rx.update($0)
        })
    }
    
    func fetchDataFromStorage(items: PublishSubject<[UsersModel.UserEntity]>) {
        managedObjectContext.rx.entities(UsersModel.UserEntity.self, sortDescriptors: []).subscribe { (response) in
            items.onNext(response.element ?? [])
            items.onCompleted()
        }
        .disposed(by: disposeBag)
    }
}
