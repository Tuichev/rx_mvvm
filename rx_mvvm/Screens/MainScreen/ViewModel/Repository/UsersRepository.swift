//
//  UsersRepository.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation
import RxSwift

class UsersRepository {
    private let usersAPI = UsersAPI()
    private let userStorage = UsersLocalStorage()
    
    func fetchData(items: PublishSubject<[UsersModel.UserEntity]>) {
        let hasInternerConnection = Reachability.shared.isConnected
        
        if hasInternerConnection {
            usersAPI.fetchDataFromApi(items: items, localStorage: userStorage)
        } else {
            userStorage.fetchDataFromStorage(items: items)
        }
    }
}
