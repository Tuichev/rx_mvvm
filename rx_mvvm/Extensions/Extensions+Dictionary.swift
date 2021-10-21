//
//  Extensions+Dictionary.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation

extension Dictionary {
     func queryItems() -> String {
        guard let dic = self as? [String: Any] else { return "" }
        
        var components = URLComponents()
        components.queryItems = dic.map {
            URLQueryItem(name: $0, value: String(describing: $1))
        }
        
        let customAllowedSet = CharacterSet.init(charactersIn: "_+-").inverted
        return components.url?.absoluteString.addingPercentEncoding(withAllowedCharacters: customAllowedSet) ?? ""
    }
}
