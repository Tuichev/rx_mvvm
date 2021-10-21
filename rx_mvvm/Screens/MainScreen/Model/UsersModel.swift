//
//  MainScreenModel.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation

enum UsersModel {
    
    struct UserRequest: Codable {
        let perPage: Int
        
        enum CodingKeys: String, CodingKey {
            case perPage = "per_page"
        }
    }
    
    struct UserResponse: Codable {
        let users: [UserEntity]
        
        enum CodingKeys: String, CodingKey {
            case users = "data"
        }
    }
    
    struct UserEntity: Codable {
        let id: Int
        let email: String?
        let firstName: String?
        let lastName: String?
        let avatar: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case email
            case firstName = "first_name"
            case lastName = "last_name"
            case avatar
        }
    }
}
