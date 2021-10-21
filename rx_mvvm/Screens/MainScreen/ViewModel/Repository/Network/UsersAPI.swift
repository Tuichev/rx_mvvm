//
//  UsersApi.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation
import RxAlamofire
import RxSwift

class UsersAPI {
    private let disposeBag = DisposeBag()
    
    func fetchDataFromApi(items: PublishSubject<[UsersModel.UserEntity]>, param: UsersModel.UserRequest = UsersModel.UserRequest(perPage: 10)) {
        let parameters = param.convertToParameters
        let urlWithQuery = APIEndPoints.users + parameters.queryItems()
        
        guard let url = URL(string: urlWithQuery) else { return }
        
        RxAlamofire.requestData(.get, url)
            .mapObject(type: UsersModel.UserResponse.self)
            .subscribe { (response) in
                items.onNext(response.element?.users ?? [])
                items.onCompleted()
            }
            .disposed(by: disposeBag)

    }
}