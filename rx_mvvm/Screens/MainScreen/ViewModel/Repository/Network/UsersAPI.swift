//
//  UsersApi.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation
import RxAlamofire
import RxSwift

protocol UsersAPIProtocol: AnyObject {
    func fetchDataFromApi(items: PublishSubject<[UsersModel.UserEntity]>, localStorage: UsersLocalStorageProtocol, param: UsersModel.UserRequest)
}

class UsersAPI: UsersAPIProtocol {
    private let disposeBag = DisposeBag()
    
    func fetchDataFromApi(items: PublishSubject<[UsersModel.UserEntity]>, localStorage: UsersLocalStorageProtocol, param: UsersModel.UserRequest) {
        let parameters = param.convertToParameters
        let urlWithQuery = APIEndPoints.users + parameters.queryItems()
        
        guard let url = URL(string: urlWithQuery) else { return }
        
        RxAlamofire.requestData(.get, url)
            .mapObject(type: UsersModel.UserResponse.self)
            .subscribe { [weak localStorage] (response) in
                let users = response.element?.users ?? []
                
                if !users.isEmpty {
                    localStorage?.saveDataFromApi(items: users)
                }
                
                items.onNext(users)
                items.onCompleted()
            }
            .disposed(by: disposeBag)
    }
}

extension UsersAPIProtocol {
    func fetchDataFromApi(items: PublishSubject<[UsersModel.UserEntity]>, localStorage: UsersLocalStorageProtocol, param: UsersModel.UserRequest = UsersModel.UserRequest(perPage: 10)) {
        fetchDataFromApi(items: items, localStorage: localStorage, param: param)
    }
}
