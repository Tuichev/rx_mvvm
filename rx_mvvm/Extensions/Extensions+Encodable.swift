//
//  EncodableExtensions.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import Foundation

extension Encodable {
    var convertToParameters: [String: Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        let jsonObject = (try? (JSONSerialization.jsonObject(with: data, options: []))).flatMap { $0 as? [String: Any] } ?? [:]
        var jsonObjectString: [String: Any] = [:]

        for item in jsonObject {
            
            switch item.value {
            case let array as NSArray:
                jsonObjectString[item.key] = array.count > 0 ? array : ""
                
            case let dict as NSDictionary:
                jsonObjectString[item.key] = dict.count > 0 ? dict : ""//convertValueToString(array: dict)
                
            default:
                jsonObjectString[item.key] = String(describing: item.value)
                break
            }
        }
        
        return jsonObjectString
    }
}
