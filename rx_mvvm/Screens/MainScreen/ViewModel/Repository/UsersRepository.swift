//
//  UsersRepository.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation
import RxSwift

protocol UsersRepositoryProtocol: AnyObject {
    func fetchData(items: PublishSubject<[UsersModel.UserEntity]>)
}

class UsersRepository: UsersRepositoryProtocol {
    private let usersAPI: UsersAPIProtocol
    private let userStorage: UsersLocalStorageProtocol
    
    required init(api: UsersAPIProtocol = UsersAPI(), localStorage: UsersLocalStorageProtocol = UsersLocalStorage()) {
        self.usersAPI = api
        self.userStorage = localStorage
    }
    
    func fetchData(items: PublishSubject<[UsersModel.UserEntity]>) {
        let hasInternerConnection = Reachability.shared.isConnected
        
        if hasInternerConnection {
            usersAPI.fetchDataFromApi(items: items, localStorage: userStorage)
        } else {
            userStorage.fetchDataFromStorage(items: items)
        }
    }
}
