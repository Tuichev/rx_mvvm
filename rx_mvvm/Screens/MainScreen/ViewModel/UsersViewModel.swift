//
//  UsersViewModel.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation
import RxSwift

class UsersViewModel {
    let items: PublishSubject<[UsersModel.UserEntity]> = .init()
    
    private let repository = UsersRepository()
    
    func fetchData() {
        repository.fetchData(items: items)
    }
}
