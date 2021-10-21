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
        let hasInternerConnection = true//TODO: add listner from alamofire
        
        if hasInternerConnection {
            usersAPI.fetchDataFromApi(items: items)
        } else {
            userStorage.fetchDataFromApi(items: items)
        }
    }
}
