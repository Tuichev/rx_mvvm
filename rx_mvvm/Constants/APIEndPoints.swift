//
//  APIEndPoints.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation

struct APIEndPoints {
    private static let baseUrl = "https://reqres.in/api/"
    
    static var users: String {
        return baseUrl + "users"
    }
}
